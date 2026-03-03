/// The configuration of an Kinesis video stream.
///
/// If a meeting uses an opt-in Region as its
/// [MediaRegion](https://docs.aws.amazon.com/chime-sdk/latest/APIReference/API_meeting-chime_CreateMeeting.html#chimesdk-meeting-chime_CreateMeeting-request-MediaRegion),
/// the KVS stream must be in that same Region. For example, if a meeting uses
/// the `af-south-1` Region, the KVS stream must also be in `af-south-1`.
/// However, if the meeting uses a
/// Region that AWS turns on by default, the KVS stream can be in any available
/// Region, including an opt-in Region. For example, if the meeting uses
/// `ca-central-1`, the KVS stream can be in
/// `eu-west-2`, `us-east-1`, `af-south-1`, or any other Region that the Amazon
/// Chime SDK supports.
///
/// To learn which AWS Region a meeting uses, call the
/// [GetMeeting](https://docs.aws.amazon.com/chime-sdk/latest/APIReference/API_meeting-chime_GetMeeting.html) API and
/// use the
/// [MediaRegion](https://docs.aws.amazon.com/chime-sdk/latest/APIReference/API_meeting-chime_CreateMeeting.html#chimesdk-meeting-chime_CreateMeeting-request-MediaRegion)
/// parameter from the response.
///
/// For more information about opt-in Regions, refer to [Available
/// Regions](https://docs.aws.amazon.com/chime-sdk/latest/dg/sdk-available-regions.html) in the
/// *Amazon Chime SDK Developer Guide*, and
/// [Specify which AWS Regions your account can
/// use](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-regions.html#rande-manage-enable.html),
/// in the *AWS Account Management Reference Guide*.
pub const KinesisVideoStreamConfiguration = struct {
    /// The amount of time that data is retained.
    data_retention_in_hours: ?i32 = null,

    /// The Amazon Web Services Region of the video stream.
    region: []const u8,

    pub const json_field_names = .{
        .data_retention_in_hours = "DataRetentionInHours",
        .region = "Region",
    };
};
