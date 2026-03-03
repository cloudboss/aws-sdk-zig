const R53HostedZoneDeletionStateCode = @import("r53_hosted_zone_deletion_state_code.zig").R53HostedZoneDeletionStateCode;

/// Describes the deletion state of an Amazon Route 53 hosted zone for a domain
/// that is
/// being automatically delegated to an Amazon Lightsail DNS zone.
pub const R53HostedZoneDeletionState = struct {
    /// The status code for the deletion state.
    ///
    /// Following are the possible values:
    ///
    /// * `SUCCEEDED` - The hosted zone was successfully deleted.
    ///
    /// * `PENDING` - The hosted zone deletion is in progress.
    ///
    /// * `FAILED` - The hosted zone deletion failed.
    ///
    /// * `STARTED` - The hosted zone deletion started.
    code: ?R53HostedZoneDeletionStateCode = null,

    /// The message that describes the reason for the status code.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
