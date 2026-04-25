const DataAutomationLibraryItem = @import("data_automation_library_item.zig").DataAutomationLibraryItem;

/// DataAutomation Library configuration
pub const DataAutomationLibraryConfiguration = struct {
    libraries: ?[]const DataAutomationLibraryItem = null,

    pub const json_field_names = .{
        .libraries = "libraries",
    };
};
