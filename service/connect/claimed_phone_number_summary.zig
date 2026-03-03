const aws = @import("aws");

const PhoneNumberCountryCode = @import("phone_number_country_code.zig").PhoneNumberCountryCode;
const PhoneNumberStatus = @import("phone_number_status.zig").PhoneNumberStatus;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

/// Information about a phone number that has been claimed to your Amazon
/// Connect instance or traffic distribution group.
pub const ClaimedPhoneNumberSummary = struct {
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

    /// The status of the phone number.
    ///
    /// * `CLAIMED` means the previous
    ///   [ClaimPhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_ClaimPhoneNumber.html) or [UpdatePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumber.html)
    /// operation succeeded.
    ///
    /// * `IN_PROGRESS` means a
    ///   [ClaimPhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_ClaimPhoneNumber.html), [UpdatePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumber.html), or [UpdatePhoneNumberMetadata](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumberMetadata.html) operation is still in progress and has not yet completed. You can call [DescribePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribePhoneNumber.html) at
    /// a later time to verify if the previous operation has completed.
    ///
    /// * `FAILED` indicates that the previous
    ///   [ClaimPhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_ClaimPhoneNumber.html) or [UpdatePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumber.html)
    /// operation has failed. It will include a message indicating the failure
    /// reason. A common reason for a failure may be
    /// that the `TargetArn` value you are claiming or updating a phone number to
    /// has reached its limit of total
    /// claimed numbers. If you received a `FAILED` status from a `ClaimPhoneNumber`
    /// API call, you
    /// have one day to retry claiming the phone number before the number is
    /// released back to the inventory for other
    /// customers to claim.
    ///
    /// You will not be billed for the phone number during the 1-day period if
    /// number claiming fails.
    phone_number_status: ?PhoneNumberStatus = null,

    /// The type of phone number.
    phone_number_type: ?PhoneNumberType = null,

    /// The claimed phone number ARN that was previously imported from the external
    /// service, such as Amazon Web Services
    /// End User Messaging. If it is from Amazon Web Services End User Messaging, it
    /// looks like the ARN of the phone number
    /// that was imported from Amazon Web Services End User Messaging.
    source_phone_number_arn: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

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
        .phone_number_status = "PhoneNumberStatus",
        .phone_number_type = "PhoneNumberType",
        .source_phone_number_arn = "SourcePhoneNumberArn",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};
