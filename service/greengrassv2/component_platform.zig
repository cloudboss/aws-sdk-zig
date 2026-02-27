const aws = @import("aws");

/// Contains information about a platform that a component supports.
pub const ComponentPlatform = struct {
    /// A dictionary of attributes for the platform. The IoT Greengrass Core
    /// software defines the
    /// `os` and `architecture` by default. You can specify additional
    /// platform attributes for a core device when you deploy the Greengrass nucleus
    /// component. For more
    /// information, see the [Greengrass nucleus
    /// component](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-nucleus-component.html) in the *IoT Greengrass V2 Developer Guide*.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The friendly name of the platform. This name helps you identify the
    /// platform.
    ///
    /// If you omit this parameter, IoT Greengrass creates a friendly name from the
    /// `os` and
    /// `architecture` of the platform.
    name: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .name = "name",
    };
};
