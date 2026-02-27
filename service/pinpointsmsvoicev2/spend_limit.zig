const SpendLimitName = @import("spend_limit_name.zig").SpendLimitName;

/// Describes the current monthly spend limits for sending voice and text
/// messages. For more information on increasing your monthly spend limit, see [
/// Requesting a spending quota increase
/// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/awssupport-spend-threshold.html) in the *End User Messaging SMS User Guide*.
pub const SpendLimit = struct {
    /// The maximum amount of money, in US dollars, that you want to be able to
    /// spend sending messages each month. This value has to be less than or equal
    /// to the amount in `MaxLimit`. To use this custom limit, `Overridden` must be
    /// set to true.
    enforced_limit: i64 = 0,

    /// The maximum amount of money that you are able to spend to send messages each
    /// month, in US dollars.
    max_limit: i64 = 0,

    /// The name for the SpendLimit.
    name: SpendLimitName,

    /// When set to `True`, the value that has been specified in the `EnforcedLimit`
    /// is used to determine the maximum amount in US dollars that can be spent to
    /// send messages each month, in US dollars.
    overridden: bool = false,

    pub const json_field_names = .{
        .enforced_limit = "EnforcedLimit",
        .max_limit = "MaxLimit",
        .name = "Name",
        .overridden = "Overridden",
    };
};
