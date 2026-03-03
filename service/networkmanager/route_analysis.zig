const RouteAnalysisEndpointOptions = @import("route_analysis_endpoint_options.zig").RouteAnalysisEndpointOptions;
const RouteAnalysisPath = @import("route_analysis_path.zig").RouteAnalysisPath;
const RouteAnalysisStatus = @import("route_analysis_status.zig").RouteAnalysisStatus;

/// Describes a route analysis.
pub const RouteAnalysis = struct {
    /// The destination.
    destination: ?RouteAnalysisEndpointOptions = null,

    /// The forward path.
    forward_path: ?RouteAnalysisPath = null,

    /// The ID of the global network.
    global_network_id: ?[]const u8 = null,

    /// Indicates whether to analyze the return path. The return path is not
    /// analyzed if the forward path
    /// analysis does not succeed.
    include_return_path: bool = false,

    /// The ID of the AWS account that created the route analysis.
    owner_account_id: ?[]const u8 = null,

    /// The return path.
    return_path: ?RouteAnalysisPath = null,

    /// The ID of the route analysis.
    route_analysis_id: ?[]const u8 = null,

    /// The source.
    source: ?RouteAnalysisEndpointOptions = null,

    /// The time that the analysis started.
    start_timestamp: ?i64 = null,

    /// The status of the route analysis.
    status: ?RouteAnalysisStatus = null,

    /// Indicates whether to include the location of middlebox appliances in the
    /// route analysis.
    use_middleboxes: bool = false,

    pub const json_field_names = .{
        .destination = "Destination",
        .forward_path = "ForwardPath",
        .global_network_id = "GlobalNetworkId",
        .include_return_path = "IncludeReturnPath",
        .owner_account_id = "OwnerAccountId",
        .return_path = "ReturnPath",
        .route_analysis_id = "RouteAnalysisId",
        .source = "Source",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
        .use_middleboxes = "UseMiddleboxes",
    };
};
