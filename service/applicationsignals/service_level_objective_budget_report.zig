const ServiceLevelObjectiveBudgetStatus = @import("service_level_objective_budget_status.zig").ServiceLevelObjectiveBudgetStatus;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const Goal = @import("goal.zig").Goal;
const RequestBasedServiceLevelIndicator = @import("request_based_service_level_indicator.zig").RequestBasedServiceLevelIndicator;
const ServiceLevelIndicator = @import("service_level_indicator.zig").ServiceLevelIndicator;

/// A structure containing an SLO budget report that you have requested.
pub const ServiceLevelObjectiveBudgetReport = struct {
    /// The ARN of the SLO that this report is for.
    arn: []const u8,

    /// A number between 0 and 100 that represents the success percentage of your
    /// application compared to the goal set by the SLO.
    ///
    /// If this is a period-based SLO, the number is the percentage of time periods
    /// that the service has attained the SLO's attainment goal, as of the time of
    /// the request.
    ///
    /// If this is a request-based SLO, the number is the number of successful
    /// requests divided by the number of total requests, multiplied by 100, during
    /// the time range that you specified in your request.
    attainment: ?f64 = null,

    /// This field is displayed only for request-based SLOs. It displays the number
    /// of failed requests that can be tolerated before any more successful requests
    /// occur, and still have the application meet its SLO goal.
    ///
    /// This number can go up and down between different reports, based on both how
    /// many successful requests and how many failed requests occur in that time.
    budget_requests_remaining: ?i32 = null,

    /// The budget amount remaining before the SLO status becomes `BREACHING`, at
    /// the time specified in the `Timestemp` parameter of the request. If this
    /// value is negative, then the SLO is already in `BREACHING` status.
    ///
    /// This field is included only if the SLO is a period-based SLO.
    budget_seconds_remaining: ?i32 = null,

    /// The status of this SLO, as it relates to the error budget for the entire
    /// time interval.
    ///
    /// * `OK` means that the SLO had remaining budget above the warning threshold,
    ///   as of the time that you specified in `TimeStamp`.
    /// * `WARNING` means that the SLO's remaining budget was below the warning
    ///   threshold, as of the time that you specified in `TimeStamp`.
    /// * `BREACHED` means that the SLO's budget was exhausted, as of the time that
    ///   you specified in `TimeStamp`.
    /// * `INSUFFICIENT_DATA` means that the specified start and end times were
    ///   before the SLO was created, or that attainment data is missing.
    budget_status: ServiceLevelObjectiveBudgetStatus,

    /// Displays whether this budget report is for a period-based SLO or a
    /// request-based SLO.
    evaluation_type: ?EvaluationType = null,

    goal: ?Goal = null,

    /// The name of the SLO that this report is for.
    name: []const u8,

    request_based_sli: ?RequestBasedServiceLevelIndicator = null,

    /// A structure that contains information about the performance metric that this
    /// SLO monitors.
    sli: ?ServiceLevelIndicator = null,

    /// This field is displayed only for request-based SLOs. It displays the total
    /// number of failed requests that can be tolerated during the time range
    /// between the start of the interval and the time stamp supplied in the budget
    /// report request. It is based on the total number of requests that occurred,
    /// and the percentage specified in the attainment goal. If the number of failed
    /// requests matches this number or is higher, then this SLO is currently
    /// breaching.
    ///
    /// This number can go up and down between reports with different time stamps,
    /// based on both how many total requests occur.
    total_budget_requests: ?i32 = null,

    /// The total number of seconds in the error budget for the interval. This field
    /// is included only if the SLO is a period-based SLO.
    total_budget_seconds: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .attainment = "Attainment",
        .budget_requests_remaining = "BudgetRequestsRemaining",
        .budget_seconds_remaining = "BudgetSecondsRemaining",
        .budget_status = "BudgetStatus",
        .evaluation_type = "EvaluationType",
        .goal = "Goal",
        .name = "Name",
        .request_based_sli = "RequestBasedSli",
        .sli = "Sli",
        .total_budget_requests = "TotalBudgetRequests",
        .total_budget_seconds = "TotalBudgetSeconds",
    };
};
