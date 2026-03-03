const VerifiedAccessLogs = @import("verified_access_logs.zig").VerifiedAccessLogs;

/// Describes logging options for an Amazon Web Services Verified Access
/// instance.
pub const VerifiedAccessInstanceLoggingConfiguration = struct {
    /// Details about the logging options.
    access_logs: ?VerifiedAccessLogs = null,

    /// The ID of the Amazon Web Services Verified Access instance.
    verified_access_instance_id: ?[]const u8 = null,
};
