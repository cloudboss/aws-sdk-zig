const VerificationStatus = @import("verification_status.zig").VerificationStatus;

/// Provides information about the requested verified destintion phone number.
pub const VerifiedDestinationNumberInformation = struct {
    /// The time when the destination phone number was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The verified destination phone number, in E.164 format.
    destination_phone_number: []const u8,

    /// The status of the verified destination phone number.
    ///
    /// * `PENDING`: The phone number hasn't been verified yet.
    /// * `VERIFIED`: The phone number is verified and can receive messages.
    status: VerificationStatus,

    /// The Amazon Resource Name (ARN) for the verified destination phone number.
    verified_destination_number_arn: []const u8,

    /// The unique identifier for the verified destination phone number.
    verified_destination_number_id: []const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .destination_phone_number = "DestinationPhoneNumber",
        .status = "Status",
        .verified_destination_number_arn = "VerifiedDestinationNumberArn",
        .verified_destination_number_id = "VerifiedDestinationNumberId",
    };
};
