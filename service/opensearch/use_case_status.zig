const DomainUseCase = @import("domain_use_case.zig").DomainUseCase;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of the use case for the domain.
pub const UseCaseStatus = struct {
    /// The use case configured for the domain.
    options: DomainUseCase,

    /// The current status of the use case for the domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
