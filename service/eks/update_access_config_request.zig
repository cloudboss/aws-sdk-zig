const AuthenticationMode = @import("authentication_mode.zig").AuthenticationMode;

/// The access configuration information for the cluster.
pub const UpdateAccessConfigRequest = struct {
    /// The desired authentication mode for the cluster.
    authentication_mode: ?AuthenticationMode,

    pub const json_field_names = .{
        .authentication_mode = "authenticationMode",
    };
};
