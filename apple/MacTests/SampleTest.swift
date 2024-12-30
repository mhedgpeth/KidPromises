import Testing

struct SampleTest {
    @Test func add() async throws {
        #expect(1 + 1 == 2)
    }
}
