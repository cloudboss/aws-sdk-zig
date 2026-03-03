const ExistingEnrollmentAction = @import("existing_enrollment_action.zig").ExistingEnrollmentAction;
const EnrollmentJobFraudDetectionConfig = @import("enrollment_job_fraud_detection_config.zig").EnrollmentJobFraudDetectionConfig;

/// Contains configurations defining enrollment behavior for the batch job.
pub const EnrollmentConfig = struct {
    /// The action to take when the specified speaker is already enrolled in the
    /// specified
    /// domain. The default value is `SKIP`, which skips the enrollment for the
    /// existing speaker. Setting the value to `OVERWRITE` replaces the existing
    /// voice prints and enrollment audio stored for that speaker with new data
    /// generated from
    /// the latest audio.
    existing_enrollment_action: ?ExistingEnrollmentAction = null,

    /// The fraud detection configuration to use for the speaker enrollment job.
    fraud_detection_config: ?EnrollmentJobFraudDetectionConfig = null,

    pub const json_field_names = .{
        .existing_enrollment_action = "ExistingEnrollmentAction",
        .fraud_detection_config = "FraudDetectionConfig",
    };
};
