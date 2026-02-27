const OptionStatus = @import("option_status.zig").OptionStatus;

/// The configured access rules for the domain's document and search endpoints,
/// and the current status of those rules.
pub const AccessPoliciesStatus = struct {
    options: []const u8,

    status: OptionStatus,
};
