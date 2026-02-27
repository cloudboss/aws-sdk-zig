const TtlDurationUnit = @import("ttl_duration_unit.zig").TtlDurationUnit;

/// Time to live duration, where the record is hard deleted after the expiration
/// time is
/// reached; `ExpiresAt` = `EventTime` + `TtlDuration`. For
/// information on HardDelete, see the
/// [DeleteRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_DeleteRecord.html) API in the Amazon SageMaker API Reference guide.
pub const TtlDuration = struct {
    /// `TtlDuration` time unit.
    unit: TtlDurationUnit,

    /// `TtlDuration` time value.
    value: i32,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
