const InspectionErrorDetails = @import("inspection_error_details.zig").InspectionErrorDetails;
const InspectionDataRequest = @import("inspection_data_request.zig").InspectionDataRequest;
const InspectionDataResponse = @import("inspection_data_response.zig").InspectionDataResponse;

/// Contains additional details about the state's execution, including its input
/// and output data processing flow, and HTTP request and response information.
pub const InspectionData = struct {
    /// The input after Step Functions applies an Arguments filter. This event will
    /// only be present when QueryLanguage for the state machine or individual
    /// states is set to JSONata. For more info, see [Transforming data with Step
    /// Functions](https://docs.aws.amazon.com/step-functions/latest/dg/data-transform.html).
    after_arguments: ?[]const u8,

    /// The input after Step Functions applies the
    /// [InputPath](https://docs.aws.amazon.com/step-functions/latest/dg/input-output-inputpath-params.html#input-output-inputpath) filter. Not populated when QueryLanguage is JSONata.
    after_input_path: ?[]const u8,

    /// The effective input after the ItemBatcher filter is applied in a Map state.
    after_item_batcher: ?[]const u8,

    /// An array containing the inputs for each Map iteration, transformed by the
    /// ItemSelector specified in a Map state.
    after_item_selector: ?[]const u8,

    /// The effective input after the ItemsPath filter is applied. Not populated
    /// when the QueryLanguage is JSONata.
    after_items_path: ?[]const u8,

    /// The effective input after the ItemsPointer filter is applied in a Map state.
    after_items_pointer: ?[]const u8,

    /// The effective input after Step Functions applies the
    /// [Parameters](https://docs.aws.amazon.com/step-functions/latest/dg/input-output-inputpath-params.html#input-output-parameters) filter. Not populated when QueryLanguage is JSONata.
    after_parameters: ?[]const u8,

    /// The effective result combined with the raw state input after Step Functions
    /// applies the
    /// [ResultPath](https://docs.aws.amazon.com/step-functions/latest/dg/input-output-resultpath.html) filter. Not populated when QueryLanguage is JSONata.
    after_result_path: ?[]const u8,

    /// The effective result after Step Functions applies the
    /// [ResultSelector](https://docs.aws.amazon.com/step-functions/latest/dg/input-output-inputpath-params.html#input-output-resultselector) filter. Not populated when QueryLanguage is JSONata.
    after_result_selector: ?[]const u8,

    /// An object containing data about a handled exception in the tested state.
    error_details: ?InspectionErrorDetails,

    /// The raw state input.
    input: ?[]const u8,

    /// The max concurrency of the Map state.
    max_concurrency: ?i32,

    /// The raw HTTP request that is sent when you test an HTTP Task.
    request: ?InspectionDataRequest,

    /// The raw HTTP response that is returned when you test an HTTP Task.
    response: ?InspectionDataResponse,

    /// The state's raw result.
    result: ?[]const u8,

    /// The tolerated failure threshold for a Map state as defined in number of Map
    /// state iterations.
    tolerated_failure_count: ?i32,

    /// The tolerated failure threshold for a Map state as defined in percentage of
    /// Map state iterations.
    tolerated_failure_percentage: ?f32,

    /// JSON string that contains the set of workflow variables after execution of
    /// the state. The set will include variables assigned in the state and
    /// variables set up as test state input.
    variables: ?[]const u8,

    pub const json_field_names = .{
        .after_arguments = "afterArguments",
        .after_input_path = "afterInputPath",
        .after_item_batcher = "afterItemBatcher",
        .after_item_selector = "afterItemSelector",
        .after_items_path = "afterItemsPath",
        .after_items_pointer = "afterItemsPointer",
        .after_parameters = "afterParameters",
        .after_result_path = "afterResultPath",
        .after_result_selector = "afterResultSelector",
        .error_details = "errorDetails",
        .input = "input",
        .max_concurrency = "maxConcurrency",
        .request = "request",
        .response = "response",
        .result = "result",
        .tolerated_failure_count = "toleratedFailureCount",
        .tolerated_failure_percentage = "toleratedFailurePercentage",
        .variables = "variables",
    };
};
