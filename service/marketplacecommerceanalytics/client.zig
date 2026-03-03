const aws = @import("aws");
const std = @import("std");

const generate_data_set = @import("generate_data_set.zig");
const start_support_data_export = @import("start_support_data_export.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Marketplace Commerce Analytics";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Given a data set type and data set publication date, asynchronously
    /// publishes the requested data set to the specified
    /// S3 bucket and notifies the specified SNS topic once the data is available.
    /// Returns a unique request identifier that
    /// can be used to correlate requests with notifications from the SNS topic.
    /// Data sets will be published in comma-separated values (CSV) format with the
    /// file name {data_set_type}_YYYY-MM-DD.csv.
    /// If a file with the same name already exists (e.g. if the same data set is
    /// requested twice), the original file will
    /// be overwritten by the new file.
    /// Requires a Role with an attached permissions policy providing Allow
    /// permissions for the following actions:
    /// s3:PutObject, s3:GetBucketLocation, sns:GetTopicAttributes, sns:Publish,
    /// iam:GetRolePolicy.
    pub fn generateDataSet(self: *Self, allocator: std.mem.Allocator, input: generate_data_set.GenerateDataSetInput, options: generate_data_set.Options) !generate_data_set.GenerateDataSetOutput {
        return generate_data_set.execute(self, allocator, input, options);
    }

    /// *This target has been deprecated.* Given a data set type and a from date,
    /// asynchronously publishes the requested customer support data
    /// to the specified S3 bucket and notifies the specified SNS topic once the
    /// data is available. Returns a unique request
    /// identifier that can be used to correlate requests with notifications from
    /// the SNS topic.
    /// Data sets will be published in comma-separated values (CSV) format with the
    /// file name {data_set_type}_YYYY-MM-DD'T'HH-mm-ss'Z'.csv.
    /// If a file with the same name already exists (e.g. if the same data set is
    /// requested twice), the original file will
    /// be overwritten by the new file.
    /// Requires a Role with an attached permissions policy providing Allow
    /// permissions for the following actions:
    /// s3:PutObject, s3:GetBucketLocation, sns:GetTopicAttributes, sns:Publish,
    /// iam:GetRolePolicy.
    pub fn startSupportDataExport(self: *Self, allocator: std.mem.Allocator, input: start_support_data_export.StartSupportDataExportInput, options: start_support_data_export.Options) !start_support_data_export.StartSupportDataExportOutput {
        return start_support_data_export.execute(self, allocator, input, options);
    }
};
