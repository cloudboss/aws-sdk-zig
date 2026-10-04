const ExperimentRunEventType = @import("experiment_run_event_type.zig").ExperimentRunEventType;
const TreatmentOverrides = @import("treatment_overrides.zig").TreatmentOverrides;
const TriggeredBy = @import("triggered_by.zig").TriggeredBy;

/// Describes an event that occurred during an experiment run.
pub const ExperimentRunEvent = struct {
    /// The Amazon Resource Name (ARN) of the deployment associated with this event.
    associated_deployment: ?[]const u8 = null,

    /// A description of the event.
    description: ?[]const u8 = null,

    /// The type of event. Valid values: `RUN_STARTED`, `EXPOSURE_UPDATED`,
    /// `OVERRIDES_UPDATED`, `RUN_STOPPED`.
    event_type: ?ExperimentRunEventType = null,

    /// The exposure percentage at the time of the event.
    exposure_percentage: ?f32 = null,

    /// The date and time the event occurred, in ISO 8601 format.
    occurred_at: ?i64 = null,

    /// The treatment overrides at the time of the event.
    treatment_overrides: ?TreatmentOverrides = null,

    /// The principal that triggered the event.
    triggered_by: ?TriggeredBy = null,

    pub const json_field_names = .{
        .associated_deployment = "AssociatedDeployment",
        .description = "Description",
        .event_type = "EventType",
        .exposure_percentage = "ExposurePercentage",
        .occurred_at = "OccurredAt",
        .treatment_overrides = "TreatmentOverrides",
        .triggered_by = "TriggeredBy",
    };
};
