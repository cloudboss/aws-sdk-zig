const std = @import("std");

/// A list of the variables to use in searching or filtering `DataSource`.
///
/// * `CreatedAt` - Sets the search criteria to `DataSource` creation date.
///
/// * `Status` - Sets the search criteria to `DataSource` status.
///
/// * `Name` - Sets the search criteria to the contents of `DataSource`
/// `Name`.
///
/// * `DataUri` - Sets the search criteria to the URI of data files used to
///   create the `DataSource`. The URI can identify either a file or an Amazon
///   Simple Storage Service (Amazon S3) bucket or directory.
///
/// * `IAMUser` - Sets the search criteria to the user account that invoked the
///   `DataSource` creation.
///
/// **Note:**
/// The variable names should match the variable names in the `DataSource`.
pub const DataSourceFilterVariable = enum {
    created_at,
    last_updated_at,
    status,
    name,
    data_uri,
    iam_user,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .name = "Name",
        .data_uri = "DataLocationS3",
        .iam_user = "IAMUser",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_at => "CreatedAt",
            .last_updated_at => "LastUpdatedAt",
            .status => "Status",
            .name => "Name",
            .data_uri => "DataLocationS3",
            .iam_user => "IAMUser",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
