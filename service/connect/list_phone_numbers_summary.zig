const PhoneNumberCountryCode = @import("phone_number_country_code.zig").PhoneNumberCountryCode;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

/// Information about phone numbers that have been claimed to your Amazon
/// Connect instance or traffic distribution group.
pub const ListPhoneNumbersSummary = struct {
    /// The identifier of the Amazon Connect instance that phone numbers are claimed
    /// to. You
    /// can [find the
    /// instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: ?[]const u8 = null,

    /// The phone number. Phone numbers are formatted `[+] [country code]
    /// [subscriber number including area code]`.
    phone_number: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the phone number.
    phone_number_arn: ?[]const u8 = null,

    /// The ISO country code.
    phone_number_country_code: ?PhoneNumberCountryCode = null,

    /// The description of the phone number.
    phone_number_description: ?[]const u8 = null,

    /// A unique identifier for the phone number.
    phone_number_id: ?[]const u8 = null,

    /// The type of phone number.
    phone_number_type: ?PhoneNumberType = null,

    /// The claimed phone number ARN that was previously imported from the external
    /// service, such as Amazon Web Services
    /// End User Messaging. If it is from Amazon Web Services End User Messaging, it
    /// looks like the ARN of the phone number
    /// that was imported from Amazon Web Services End User Messaging.
    source_phone_number_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for Amazon Connect instances or traffic
    /// distribution groups that phone number inbound traffic is routed through.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .phone_number = "PhoneNumber",
        .phone_number_arn = "PhoneNumberArn",
        .phone_number_country_code = "PhoneNumberCountryCode",
        .phone_number_description = "PhoneNumberDescription",
        .phone_number_id = "PhoneNumberId",
        .phone_number_type = "PhoneNumberType",
        .source_phone_number_arn = "SourcePhoneNumberArn",
        .target_arn = "TargetArn",
    };
};
