const std = @import("std");

/// The status of a flat-rate pricing subscription.
///
/// Possible values:
///
/// * `PENDING_APPROVAL` — The subscription was created with manual approval and
///   is waiting for an `ApprovePaidSubscription` call.
/// * `ACTIVE` — The subscription is active and resources are covered by
///   flat-rate pricing.
/// * `SYNC_IN_PROGRESS` — A change is being applied to the subscription. Wait
///   for the operation to complete before making additional changes.
/// * `FAILED` — The subscription encountered an error. Check the `statusReason`
///   field for details.
pub const Status = enum {
    pending_approval,
    active,
    sync_in_progress,
    failed,

    pub const json_field_names = .{
        .pending_approval = "PENDING_APPROVAL",
        .active = "ACTIVE",
        .sync_in_progress = "SYNC_IN_PROGRESS",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_approval => "PENDING_APPROVAL",
            .active => "ACTIVE",
            .sync_in_progress => "SYNC_IN_PROGRESS",
            .failed => "FAILED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
