const TimeToLiveStatus = @import("time_to_live_status.zig").TimeToLiveStatus;

/// Enable custom Time to Live (TTL) settings for rows and columns without
/// setting a TTL default for the specified table.
///
/// For more information, see [Enabling TTL on
/// tables](https://docs.aws.amazon.com/keyspaces/latest/devguide/TTL-how-it-works.html#ttl-howitworks_enabling) in the *Amazon Keyspaces Developer Guide*.
pub const TimeToLive = struct {
    /// Shows how to enable custom Time to Live (TTL) settings for the specified
    /// table.
    status: TimeToLiveStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
