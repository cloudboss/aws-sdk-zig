const aws = @import("aws");

const ErrorResponse = @import("error_response.zig").ErrorResponse;
const HttpMethod = @import("http_method.zig").HttpMethod;
const RouteType = @import("route_type.zig").RouteType;
const RouteState = @import("route_state.zig").RouteState;

/// The summary information for the routes as a response to `ListRoutes`.
pub const RouteSummary = struct {
    /// If set to `true`, this option appends the source path to the service URL
    /// endpoint.
    append_source_path: ?bool = null,

    /// The unique identifier of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the route.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the route creator.
    created_by_account_id: ?[]const u8 = null,

    /// A timestamp that indicates when the route is created.
    created_time: ?i64 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the route resource.
    @"error": ?ErrorResponse = null,

    /// Indicates whether to match all subpaths of the given source path. If this
    /// value is
    /// `false`, requests must match the source path exactly before they are
    /// forwarded to
    /// this route's service.
    include_child_paths: ?bool = null,

    /// A timestamp that indicates when the route was last updated.
    last_updated_time: ?i64 = null,

    /// A list of HTTP methods to match. An empty list matches all values. If a
    /// method is present,
    /// only HTTP requests using that method are forwarded to this route’s service.
    methods: ?[]const HttpMethod = null,

    /// The Amazon Web Services account ID of the route owner.
    owner_account_id: ?[]const u8 = null,

    /// A mapping of Amazon API Gateway path resources to resource IDs.
    path_resource_to_id: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier of the route.
    route_id: ?[]const u8 = null,

    /// The route type of the route.
    route_type: ?RouteType = null,

    /// The unique identifier of the service.
    service_id: ?[]const u8 = null,

    /// This is the path that Refactor Spaces uses to match traffic. Paths must
    /// start with `/` and are relative to
    /// the base of the application. To use path parameters in the source path, add
    /// a variable in curly braces. For example, the resource path {user} represents
    /// a path parameter called 'user'.
    source_path: ?[]const u8 = null,

    /// The current state of the route.
    state: ?RouteState = null,

    /// The tags assigned to the route.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .append_source_path = "AppendSourcePath",
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .include_child_paths = "IncludeChildPaths",
        .last_updated_time = "LastUpdatedTime",
        .methods = "Methods",
        .owner_account_id = "OwnerAccountId",
        .path_resource_to_id = "PathResourceToId",
        .route_id = "RouteId",
        .route_type = "RouteType",
        .service_id = "ServiceId",
        .source_path = "SourcePath",
        .state = "State",
        .tags = "Tags",
    };
};
