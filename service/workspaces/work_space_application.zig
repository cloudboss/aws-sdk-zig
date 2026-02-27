const WorkSpaceApplicationLicenseType = @import("work_space_application_license_type.zig").WorkSpaceApplicationLicenseType;
const WorkSpaceApplicationState = @import("work_space_application_state.zig").WorkSpaceApplicationState;
const Compute = @import("compute.zig").Compute;
const OperatingSystemName = @import("operating_system_name.zig").OperatingSystemName;

/// Describes the WorkSpace application.
pub const WorkSpaceApplication = struct {
    /// The identifier of the application.
    application_id: ?[]const u8,

    /// The time the application is created.
    created: ?i64,

    /// The description of the WorkSpace application.
    description: ?[]const u8,

    /// The license availability for the applications.
    license_type: ?WorkSpaceApplicationLicenseType,

    /// The name of the WorkSpace application.
    name: ?[]const u8,

    /// The owner of the WorkSpace application.
    owner: ?[]const u8,

    /// The status of WorkSpace application.
    state: ?WorkSpaceApplicationState,

    /// The supported compute types of the WorkSpace application.
    supported_compute_type_names: ?[]const Compute,

    /// The supported operating systems of the WorkSpace application.
    supported_operating_system_names: ?[]const OperatingSystemName,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .created = "Created",
        .description = "Description",
        .license_type = "LicenseType",
        .name = "Name",
        .owner = "Owner",
        .state = "State",
        .supported_compute_type_names = "SupportedComputeTypeNames",
        .supported_operating_system_names = "SupportedOperatingSystemNames",
    };
};
