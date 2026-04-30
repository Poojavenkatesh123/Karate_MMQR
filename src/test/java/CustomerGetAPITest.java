package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class ParallelRunner {

    public static void main(String[] args) {
        Results results = Runner.path("classpath:features")
                                .parallel(5);

        if (results.getFailCount() > 0) {
            throw new RuntimeException("Test failed");
        }
    }
}