package runners;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

/**
 * Single runner for all Karate features.
 *
 * Run options:
 *   mvn clean test -Dtest=AllTestsRunner                        (runs every @Test below)
 *   mvn clean test -Dtest=AllTestsRunner#runAll                 (everything under classpath:features)
 *   mvn clean test -Dtest=AllTestsRunner#runPayments            (payment.feature - all 5 types)
 *   mvn clean test -Dtest=AllTestsRunner#runCustomerOnboard     (CustomerOnboard features)
 *   mvn clean test -Dtest=AllTestsRunner#runSmoke               (@smoke tag, ignores @ignore)
 *   mvn clean test -Dtest=AllTestsRunner#runRegression          (@regression tag, ignores @ignore)
 *
 * Reports: target/karate-reports/karate-summary.html
 * Custom payment log: target/karate-logs/payments.log
 */
public class AllTestsRunner {

    @Test
    void runAll() {
        Results results = Runner.path("classpath:features")
                .tags("~@ignore")
                .outputCucumberJson(true)
                .outputHtmlReport(true)
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void runPayments() {
        Results results = Runner.path("classpath:features/payments/payment.feature")
                .outputCucumberJson(true)
                .outputHtmlReport(true)
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void runCustomerOnboard() {
        Results results = Runner.path("classpath:features/CustomerOnboard")
                .outputCucumberJson(true)
                .outputHtmlReport(true)
                .parallel(3);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void runSmoke() {
        Results results = Runner.path("classpath:features")
                .tags("@smoke", "~@ignore")
                .outputCucumberJson(true)
                .outputHtmlReport(true)
                .parallel(2);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void runRegression() {
        Results results = Runner.path("classpath:features")
                .tags("@regression", "~@ignore")
                .outputCucumberJson(true)
                .outputHtmlReport(true)
                .parallel(3);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
