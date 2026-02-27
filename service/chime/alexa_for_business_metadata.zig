/// The Alexa for Business metadata associated with an Amazon Chime user, used
/// to integrate Alexa for Business with a device.
pub const AlexaForBusinessMetadata = struct {
    /// The ARN of the room resource.
    alexa_for_business_room_arn: ?[]const u8,

    /// Starts or stops Alexa for Business.
    is_alexa_for_business_enabled: ?bool,

    pub const json_field_names = .{
        .alexa_for_business_room_arn = "AlexaForBusinessRoomArn",
        .is_alexa_for_business_enabled = "IsAlexaForBusinessEnabled",
    };
};
