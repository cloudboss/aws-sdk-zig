const RegistrationType = @import("registration_type.zig").RegistrationType;

/// Additional tax information associated with your TRN in Spain.
pub const SpainAdditionalInfo = struct {
    /// The registration type in Spain.
    registration_type: RegistrationType,

    pub const json_field_names = .{
        .registration_type = "registrationType",
    };
};
