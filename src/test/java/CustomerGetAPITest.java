import com.intuit.karate.junit5.Karate;

class CustomerGetAPITest {

    @Karate.Test
    Karate testCustomerGetAPI() {
        return Karate.run("classpath:features/CustomerGetAPI.feature").parallel(5);
    }
}