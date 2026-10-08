const DeliveryStreamFailureType = @import("delivery_stream_failure_type.zig").DeliveryStreamFailureType;

/// Provides details in case one of the following operations fails due to an
/// error related
/// to KMS: CreateDeliveryStream, DeleteDeliveryStream,
/// StartDeliveryStreamEncryption, StopDeliveryStreamEncryption.
pub const FailureDescription = struct {
    /// A message providing details about the error that caused the failure.
    details: []const u8,

    /// The type of error that caused the failure.
    type: DeliveryStreamFailureType,

    pub const json_field_names = .{
        .details = "Details",
        .type = "Type",
    };
};
