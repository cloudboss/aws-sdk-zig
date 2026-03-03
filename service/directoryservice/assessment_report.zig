const AssessmentValidation = @import("assessment_validation.zig").AssessmentValidation;

/// Contains the results of validation tests performed against a specific domain
/// controller during a directory assessment.
pub const AssessmentReport = struct {
    /// The IP address of the domain controller that was tested during the
    /// assessment.
    domain_controller_ip: ?[]const u8 = null,

    /// A list of validation results for different test categories performed against
    /// this
    /// domain controller.
    validations: ?[]const AssessmentValidation = null,

    pub const json_field_names = .{
        .domain_controller_ip = "DomainControllerIp",
        .validations = "Validations",
    };
};
