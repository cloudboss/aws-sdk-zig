const ChangeStatus = @import("change_status.zig").ChangeStatus;

/// A complex type that describes change information about changes made to your
/// hosted
/// zone.
pub const ChangeInfo = struct {
    /// A comment you can provide.
    comment: ?[]const u8 = null,

    /// This element contains an ID that you use when performing a
    /// [GetChange](https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetChange.html) action to get
    /// detailed information about the change.
    id: []const u8,

    /// The current state of the request. `PENDING` indicates that this request has
    /// not yet been applied to all Amazon Route 53 DNS servers.
    status: ChangeStatus,

    /// The date and time that the change request was submitted in [ISO 8601
    /// format](https://en.wikipedia.org/wiki/ISO_8601) and Coordinated
    /// Universal Time (UTC). For example, the value `2017-03-27T17:48:16.751Z`
    /// represents March 27, 2017 at 17:48:16.751 UTC.
    submitted_at: i64,
};
