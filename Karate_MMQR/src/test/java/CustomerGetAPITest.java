import com.intuit.karate.junit5.Karate;

class CustomerGetAPITest {

    @Karate.Test
    Karate runAllCustomerOnboardTests() {
        //return Karate.run("classpath:features/CustomerOnboard");
        return Karate.run("classpath:features");
    }
}