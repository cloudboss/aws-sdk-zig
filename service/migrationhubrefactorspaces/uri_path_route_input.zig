const RouteActivationState = @import("route_activation_state.zig").RouteActivationState;
const HttpMethod = @import("http_method.zig").HttpMethod;

/// The configuration for the URI path route type.
pub const UriPathRouteInput = struct {
    /// If set to `ACTIVE`, traffic is forwarded to this route’s service after the
    /// route is created.
    activation_state: RouteActivationState,

    /// If set to `true`, this option appends the source path to the service URL
    /// endpoint.
    append_source_path: ?bool = null,

    /// Indicates whether to match all subpaths of the given source path. If this
    /// value is
    /// `false`, requests must match the source path exactly before they are
    /// forwarded to
    /// this route's service.
    include_child_paths: ?bool = null,

    /// A list of HTTP methods to match. An empty list matches all values. If a
    /// method is present,
    /// only HTTP requests using that method are forwarded to this route’s service.
    methods: ?[]const HttpMethod = null,

    /// This is the path that Refactor Spaces uses to match traffic. Paths must
    /// start with `/` and are relative to
    /// the base of the application. To use path parameters in the source path, add
    /// a variable in curly braces.
    /// For example, the resource path {user} represents a path parameter called
    /// 'user'.
    source_path: []const u8,

    pub const json_field_names = .{
        .activation_state = "ActivationState",
        .append_source_path = "AppendSourcePath",
        .include_child_paths = "IncludeChildPaths",
        .methods = "Methods",
        .source_path = "SourcePath",
    };
};
