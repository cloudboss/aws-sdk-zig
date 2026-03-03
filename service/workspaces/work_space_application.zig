const WorkSpaceApplicationLicenseType = @import("work_space_application_license_type.zig").WorkSpaceApplicationLicenseType;
const WorkSpaceApplicationState = @import("work_space_application_state.zig").WorkSpaceApplicationState;
const Compute = @import("compute.zig").Compute;
const OperatingSystemName = @import("operating_system_name.zig").OperatingSystemName;

/// Describes the WorkSpace application.
pub const WorkSpaceApplication = struct {
    /// The identifier of the application.
    application_id: ?[]const u8 = null,

    /// The time the application is created.
    created: ?i64 = null,

    /// The description of the WorkSpace application.
    description: ?[]const u8 = null,

    /// The license availability for the applications.
    license_type: ?WorkSpaceApplicationLicenseType = null,

    /// The name of the WorkSpace application.
    name: ?[]const u8 = null,

    /// The owner of the WorkSpace application.
    owner: ?[]const u8 = null,

    /// The status of WorkSpace application.
    state: ?WorkSpaceApplicationState = null,

    /// The supported compute types of the WorkSpace application.
    supported_compute_type_names: ?[]const Compute = null,

    /// The supported operating systems of the WorkSpace application.
    supported_operating_system_names: ?[]const OperatingSystemName = null,

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
