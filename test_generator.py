class TestGenerator:
    WORD_SIZE = 32

    K_CONSTANTS = [
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
        0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
        0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
        0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
        0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
        0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
        0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
        0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
        0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
    ]

    def __init__(self):
        self.a = 0
        self.b = 0
        self.c = 0
        self.d = 0
        self.e = 0
        self.f = 0
        self.g = 0
        self.h = 0
        self.wt = 0
        self.kt = 0
        self.t1 = 0
        self.t2 = 0
        self.message_schedule = []

    def init(self, args):
        self.a = self.in_32_bits(args[0])
        print("a = " + format(self.a, '02x'))

        self.b = self.in_32_bits(args[1])
        print("b = " + format(self.b, '02x'))

        self.c = self.in_32_bits(args[2])
        print("c = " + format(self.c, '02x'))

        self.d = self.in_32_bits(args[3])
        print("d = " + format(self.d, '02x'))

        self.e = self.in_32_bits(args[4])
        print("e = " + format(self.e, '02x'))

        self.f = self.in_32_bits(args[5])
        print("f = " + format(self.f, '02x'))

        self.g = self.in_32_bits(args[6])
        print("g = " + format(self.g, '02x'))

        self.h = self.in_32_bits(args[7])
        print("h = " + format(self.h, '02x'))

        self.wt = self.in_32_bits(args[8])
        print("wt = " + format(self.wt, '02x'))

        self.kt = self.in_32_bits(args[9])
        print("kt = " + format(self.kt, '02x') + "\n")

    def get_working_variables(self):
        return [
            self.a,
            self.b,
            self.c,
            self.d,
            self.e,
            self.f,
            self.g,
            self.h
        ]

    def compute(self):
        self.read_working_variables()
        self.read_message_schedule()

        self.t1 = self.add_32_bit([self.h,
                                   self.big_sigma_1(self.e),
                                   self.ch(self.e, self.f, self.g),
                                   self.K_CONSTANTS[0],
                                   self.message_schedule[0]])

        self.t2 = self.add_32_bit([self.big_sigma_0(self.a),
                                   self.maj(self.a, self.b, self.c)])
        self.h = self.g
        self.g = self.f
        self.f = self.e
        self.e = self.add_32_bit([self.d,
                                  self.t1])
        self.d = self.c
        self.c = self.b
        self.b = self.a
        self.a = self.add_32_bit([self.t1,
                                  self.t2])

        self.add_results_to_file()

    def compute_64_round(self):

        self.read_working_variables()
        self.read_message_schedule()

        for i in range(64):
            self.t1 = self.add_32_bit([self.h,
                                       self.big_sigma_1(self.e),
                                       self.ch(self.e, self.f, self.g),
                                       self.K_CONSTANTS[i],
                                       self.message_schedule[i]])

            self.t2 = self.add_32_bit([self.big_sigma_0(self.a),
                                       self.maj(self.a, self.b, self.c)])
            self.h = self.g
            self.g = self.f
            self.f = self.e
            self.e = self.add_32_bit([self.d,
                                      self.t1])
            self.d = self.c
            self.c = self.b
            self.b = self.a
            self.a = self.add_32_bit([self.t1,
                                      self.t2])

        self.write_64_round_results()

    def compute_hash_value(self):

        self.read_working_variables()
        self.read_message_schedule()

        for i in range(64):
            self.t1 = self.add_32_bit([self.h,
                                       self.big_sigma_1(self.e),
                                       self.ch(self.e, self.f, self.g),
                                       self.K_CONSTANTS[i],
                                       self.message_schedule[i]])

            self.t2 = self.add_32_bit([self.big_sigma_0(self.a),
                                       self.maj(self.a, self.b, self.c)])
            self.h = self.g
            self.g = self.f
            self.f = self.e
            self.e = self.add_32_bit([self.d,
                                      self.t1])
            self.d = self.c
            self.c = self.b
            self.b = self.a
            self.a = self.add_32_bit([self.t1,
                                      self.t2])

        temp_vw = [self.a,
                   self.b,
                   self.c,
                   self.d,
                   self.e,
                   self.f,
                   self.g,
                   self.h]

        self.read_working_variables()

        self.a = self.add_32_bit([temp_vw[0], self.a])
        self.b = self.add_32_bit([temp_vw[1], self.b])
        self.c = self.add_32_bit([temp_vw[2], self.c])
        self.d = self.add_32_bit([temp_vw[3], self.d])
        self.e = self.add_32_bit([temp_vw[4], self.e])
        self.f = self.add_32_bit([temp_vw[5], self.f])
        self.a = self.add_32_bit([temp_vw[6], self.g])
        self.h = self.add_32_bit([temp_vw[7], self.h])

        self.write_64_round_results()

    def read_working_variables(self):
        wv_file = open('wv.txt', 'r')
        wv = []
        for i in range(8):
            wv.append(int(wv_file.readline(), 16))
            print("working variable " + str(i) + ": " + format(wv[i], '02x'))
        wv_file.close()

        self.a = wv[0]
        self.b = wv[1]
        self.c = wv[2]
        self.d = wv[3]
        self.e = wv[4]
        self.f = wv[5]
        self.g = wv[6]
        self.h = wv[7]

    def read_message_schedule(self):
        ms_file = open('ms.txt', 'r')
        ms = []
        for i in range(64):
            ms.append(int(ms_file.readline(), 16))
            print("message schedule " + str(i) + ": " + format(ms[i], '02x'))
        ms_file.close()
        self.message_schedule = ms

    def write_64_round_results(self):
        wv_file = open('res.txt', 'w')
        wv_lines = []
        for token in self.get_working_variables():
            wv_lines.append(format(token, '02x') + "\n")
        wv_file.writelines(wv_lines)
        wv_file.close()

    @staticmethod
    def in_32_bits(x):
        return x % (2 ** TestGenerator.WORD_SIZE)

    @staticmethod
    def add_32_bit(arr):
        sum = 0
        for num in arr:
            sum += num
        return TestGenerator.in_32_bits(sum)

    @staticmethod
    def ch(x, y, z):
        return TestGenerator.in_32_bits((x & y) ^ (~x & z))

    @staticmethod
    def maj(x, y, z):
        return TestGenerator.in_32_bits((x & y) ^ (x & z) ^ (y & z))

    @staticmethod
    def rotr(x, n):
        return TestGenerator.rshift(x, n) | \
               TestGenerator.in_32_bits(x << TestGenerator.WORD_SIZE - n)

    @staticmethod
    def rshift(x, n):
        return (x % 0x100000000) >> n

    @staticmethod
    def big_sigma_0(x):
        return TestGenerator.in_32_bits(
            TestGenerator.rotr(x, 2) ^ TestGenerator.rotr(x, 13) ^ TestGenerator.rotr(x, 22))

    @staticmethod
    def big_sigma_1(x):
        return TestGenerator.in_32_bits(
            TestGenerator.rotr(x, 6) ^ TestGenerator.rotr(x, 11) ^ TestGenerator.rotr(x, 25))

    # @staticmethod
    # def get_random_args(num):
    #     args = []
    #     for i in range(num):
    #         args.append(random.randint(2 ** 28, 2 ** 32))
    #     return args

    def add_results_to_file(self):
        wv_lines = []
        for token in self.get_working_variables():
            wv_lines.append(format(token, '02x') + "\n")
        self.output_file.writelines(wv_lines)


if __name__ == "__main__":
    # test_generator = TestGenerator()
    # for i in range(10):
    #     test_generator.init(test_generator.get_random_args(10))
    #     test_generator.add_initial_to_file()
    #     test_generator.compute()
    #     test_generator.add_results_to_file()
    # test_generator.finalize()

    # print(format(TestGenerator.rotr(0x0000000F, 1), '02x'))
    # print(format(2 ** 31 + 2 ** 31, '02x'))
    # print(format(TestGenerator.add_32_bit([2 ** 31, 2 ** 31]), '02x'))

    test_generator = TestGenerator()
    # test_generator.compute_64_round()
    # test_generator.compute()
    test_generator.compute_hash_value()
