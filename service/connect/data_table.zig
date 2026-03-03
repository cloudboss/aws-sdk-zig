const aws = @import("aws");

const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const DataTableStatus = @import("data_table_status.zig").DataTableStatus;
const DataTableLockLevel = @import("data_table_lock_level.zig").DataTableLockLevel;

/// Represents a data table in Amazon Connect. A data table is a JSON-like data
/// structure where attributes and
/// values are dynamically set by customers. Customers can reference table
/// values within call flows, applications, views,
/// and workspaces to pinpoint dynamic configuration that changes their contact
/// center's behavior in a predetermined and
/// safe way.
pub const DataTable = struct {
    /// The Amazon Resource Name (ARN) for the data table. Does not include version
    /// aliases.
    arn: []const u8,

    /// The timestamp when the data table was created.
    created_time: ?i64 = null,

    /// An optional description of the data table's purpose and contents.
    description: ?[]const u8 = null,

    /// The unique identifier for the data table. Does not include version aliases.
    id: []const u8,

    /// The Amazon Web Services Region where the data table was last modified, used
    /// for region replication.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when the data table or any of its properties were last
    /// modified.
    last_modified_time: i64,

    /// The lock version information used for optimistic locking and table
    /// versioning. Changes with each update to
    /// prevent concurrent modification conflicts.
    lock_version: ?DataTableLockVersion = null,

    /// The human-readable name of the data table. Must be unique within the
    /// instance and conform to Connect naming
    /// standards.
    name: []const u8,

    /// The current status of the data table. One of PUBLISHED or SAVED.
    status: ?DataTableStatus = null,

    /// Key-value pairs for attribute based access control (TBAC or ABAC) and
    /// organization.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The IANA timezone identifier used when resolving time based dynamic values.
    /// Required even if no time slices are
    /// specified.
    time_zone: []const u8,

    /// The data level that concurrent value edits are locked on. One of DATA_TABLE,
    /// PRIMARY_VALUE, ATTRIBUTE, VALUE,
    /// and NONE. Determines how concurrent edits are handled when multiple users
    /// attempt to modify values
    /// simultaneously.
    value_lock_level: ?DataTableLockLevel = null,

    /// A unique identifier and alias for customer managed versions (not $LATEST or
    /// $SAVED).
    version: ?[]const u8 = null,

    /// A description of the customer managed version.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .lock_version = "LockVersion",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .time_zone = "TimeZone",
        .value_lock_level = "ValueLockLevel",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
