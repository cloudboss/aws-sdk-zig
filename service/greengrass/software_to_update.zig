/// The piece of software on the Greengrass core that will be updated.
pub const SoftwareToUpdate = enum {
    core,
    ota_agent,

    pub const json_field_names = .{
        .core = "core",
        .ota_agent = "ota_agent",
    };
};
