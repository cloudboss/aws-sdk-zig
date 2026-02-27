const RouteAnalysisEndpointOptions = @import("route_analysis_endpoint_options.zig").RouteAnalysisEndpointOptions;
const RouteAnalysisPath = @import("route_analysis_path.zig").RouteAnalysisPath;
const RouteAnalysisStatus = @import("route_analysis_status.zig").RouteAnalysisStatus;

/// Describes a route analysis.
pub const RouteAnalysis = struct {
    /// The destination.
    destination: ?RouteAnalysisEndpointOptions,

    /// The forward path.
    forward_path: ?RouteAnalysisPath,

    /// The ID of the global network.
    global_network_id: ?[]const u8,

    /// Indicates whether to analyze the return path. The return path is not
    /// analyzed if the forward path
    /// analysis does not succeed.
    include_return_path: bool = false,

    /// The ID of the AWS account that created the route analysis.
    owner_account_id: ?[]const u8,

    /// The return path.
    return_path: ?RouteAnalysisPath,

    /// The ID of the route analysis.
    route_analysis_id: ?[]const u8,

    /// The source.
    source: ?RouteAnalysisEndpointOptions,

    /// The time that the analysis started.
    start_timestamp: ?i64,

    /// The status of the route analysis.
    status: ?RouteAnalysisStatus,

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
