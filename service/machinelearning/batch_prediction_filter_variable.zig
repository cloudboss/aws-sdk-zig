const std = @import("std");

/// A list of the variables to use in searching or filtering `BatchPrediction`.
///
/// * `CreatedAt` - Sets the search criteria to `BatchPrediction` creation date.
///
/// * `Status` - Sets the search criteria to `BatchPrediction` status.
///
/// * `Name` - Sets the search criteria to the contents of `BatchPrediction`
/// `Name`.
///
/// * `IAMUser` - Sets the search criteria to the user account that invoked the
///   `BatchPrediction` creation.
///
/// * `MLModelId` - Sets the search criteria to the `MLModel` used in the
///   `BatchPrediction`.
///
/// * `DataSourceId` - Sets the search criteria to the `DataSource` used in the
///   `BatchPrediction`.
///
/// * `DataURI` - Sets the search criteria to the data file(s) used in the
///   `BatchPrediction`. The URL can
/// identify either a file or an Amazon Simple Storage Service (Amazon S3)
/// bucket or directory.
pub const BatchPredictionFilterVariable = enum {
    created_at,
    last_updated_at,
    status,
    name,
    iam_user,
    ml_model_id,
    datasource_id,
    data_uri,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .name = "Name",
        .iam_user = "IAMUser",
        .ml_model_id = "MLModelId",
        .datasource_id = "DataSourceId",
        .data_uri = "DataURI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_at => "CreatedAt",
            .last_updated_at => "LastUpdatedAt",
            .status => "Status",
            .name => "Name",
            .iam_user => "IAMUser",
            .ml_model_id => "MLModelId",
            .datasource_id => "DataSourceId",
            .data_uri => "DataURI",
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
