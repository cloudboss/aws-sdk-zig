const aws = @import("aws");

const RouteAnalysisCompletionReasonCode = @import("route_analysis_completion_reason_code.zig").RouteAnalysisCompletionReasonCode;
const RouteAnalysisCompletionResultCode = @import("route_analysis_completion_result_code.zig").RouteAnalysisCompletionResultCode;

/// Describes the status of an analysis at completion.
pub const RouteAnalysisCompletion = struct {
    /// The reason code. Available only if a connection is not found.
    ///
    /// * `BLACKHOLE_ROUTE_FOR_DESTINATION_FOUND` - Found a black hole route with
    ///   the destination CIDR block.
    ///
    /// * `CYCLIC_PATH_DETECTED` - Found the same resource multiple times while
    ///   traversing the path.
    ///
    /// * `INACTIVE_ROUTE_FOR_DESTINATION_FOUND` - Found an inactive route with the
    ///   destination CIDR block.
    ///
    /// * `MAX_HOPS_EXCEEDED` - Analysis exceeded 64 hops without finding the
    ///   destination.
    ///
    /// * `ROUTE_NOT_FOUND` - Cannot find a route table with the destination CIDR
    ///   block.
    ///
    /// * `TGW_ATTACH_ARN_NO_MATCH` - Found an attachment, but not with the correct
    ///   destination ARN.
    ///
    /// * `TGW_ATTACH_NOT_FOUND` - Cannot find an attachment.
    ///
    /// * `TGW_ATTACH_NOT_IN_TGW` - Found an attachment, but not to the correct
    ///   transit gateway.
    ///
    /// * `TGW_ATTACH_STABLE_ROUTE_TABLE_NOT_FOUND` - The state of the route table
    ///   association is not associated.
    reason_code: ?RouteAnalysisCompletionReasonCode,

    /// Additional information about the path. Available only if a connection is not
    /// found.
    reason_context: ?[]const aws.map.StringMapEntry,

    /// The result of the analysis. If the status is `NOT_CONNECTED`, check the
    /// reason code.
    result_code: ?RouteAnalysisCompletionResultCode,

    pub const json_field_names = .{
        .reason_code = "ReasonCode",
        .reason_context = "ReasonContext",
        .result_code = "ResultCode",
    };
};
