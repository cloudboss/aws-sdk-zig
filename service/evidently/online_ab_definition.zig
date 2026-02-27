const aws = @import("aws");

/// A structure that contains the configuration of which variation to use as the
/// "control" version. The "control" version is used for comparison with other
/// variations. This structure also specifies how much experiment traffic is
/// allocated to each variation.
pub const OnlineAbDefinition = struct {
    /// The name of the variation that is the default variation that the other
    /// variations are compared to.
    control_treatment_name: ?[]const u8,

    /// A set of key-value pairs. The keys are variation names, and the values are
    /// the portion of experiment traffic to be assigned to that variation. The
    /// traffic portion is specified in thousandths of a percent, so 20,000 for a
    /// variation would allocate 20% of the experiment traffic to that variation.
    treatment_weights: ?[]const aws.map.MapEntry(i64),

    pub const json_field_names = .{
        .control_treatment_name = "controlTreatmentName",
        .treatment_weights = "treatmentWeights",
    };
};
