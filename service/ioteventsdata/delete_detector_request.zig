/// Information used to delete the detector model.
pub const DeleteDetectorRequest = struct {
    /// The name of the detector model that was used to create the detector
    /// instance.
    detector_model_name: []const u8,

    /// The value of the
    /// [key](https://docs.aws.amazon.com/iotevents/latest/apireference/API_CreateDetectorModel.html#iotevents-CreateDetectorModel-request-key) used to identify the detector.
    key_value: ?[]const u8,

    /// The ID to assign to the `DeleteDetectorRequest`. Each `"messageId"` must be
    /// unique within each batch sent.
    message_id: []const u8,

    pub const json_field_names = .{
        .detector_model_name = "detectorModelName",
        .key_value = "keyValue",
        .message_id = "messageId",
    };
};
