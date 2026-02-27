const EnableStatus = @import("enable_status.zig").EnableStatus;

/// Configuration for enabling external data filtering for third-party
/// applications to
/// access data managed by Lake Formation .
pub const ExternalFilteringConfiguration = struct {
    /// List of third-party application `ARNs` integrated with Lake Formation.
    authorized_targets: []const []const u8,

    /// Allows to enable or disable the third-party applications that are allowed to
    /// access data
    /// managed by Lake Formation.
    status: EnableStatus,

    pub const json_field_names = .{
        .authorized_targets = "AuthorizedTargets",
        .status = "Status",
    };
};
