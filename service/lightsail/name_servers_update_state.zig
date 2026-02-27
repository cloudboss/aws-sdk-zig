const NameServersUpdateStateCode = @import("name_servers_update_state_code.zig").NameServersUpdateStateCode;

/// Describes the state of the name server records update made by Amazon
/// Lightsail
/// to an Amazon Route 53 registered domain.
///
/// For more information, see [DNS in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/understanding-dns-in-amazon-lightsail) in the *Amazon Lightsail
/// Developer Guide*.
pub const NameServersUpdateState = struct {
    /// The status code for the name servers update.
    ///
    /// Following are the possible values:
    ///
    /// * `SUCCEEDED` - The name server records were successfully updated.
    ///
    /// * `PENDING` - The name server record update is in progress.
    ///
    /// * `FAILED` - The name server record update failed.
    ///
    /// * `STARTED` - The automatic name server record update started.
    code: ?NameServersUpdateStateCode,

    /// The message that describes the reason for the status code.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
