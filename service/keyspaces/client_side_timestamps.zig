const ClientSideTimestampsStatus = @import("client_side_timestamps_status.zig").ClientSideTimestampsStatus;

/// The client-side timestamp setting of the table.
///
/// For more information, see [How it works: Amazon Keyspaces client-side
/// timestamps](https://docs.aws.amazon.com/keyspaces/latest/devguide/client-side-timestamps-how-it-works.html) in the *Amazon Keyspaces Developer Guide*.
pub const ClientSideTimestamps = struct {
    /// Shows how to enable client-side timestamps settings for the specified table.
    status: ClientSideTimestampsStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
