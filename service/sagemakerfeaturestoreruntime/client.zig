const aws = @import("aws");
const std = @import("std");

const batch_get_record = @import("batch_get_record.zig");
const delete_record = @import("delete_record.zig");
const get_record = @import("get_record.zig");
const put_record = @import("put_record.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SageMaker FeatureStore Runtime";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Retrieves a batch of `Records` from a `FeatureGroup`.
    pub fn batchGetRecord(self: *Self, allocator: std.mem.Allocator, input: batch_get_record.BatchGetRecordInput, options: CallOptions) !batch_get_record.BatchGetRecordOutput {
        return batch_get_record.execute(self, allocator, input, options);
    }

    /// Deletes a `Record` from a `FeatureGroup` in the
    /// `OnlineStore`. Feature Store supports both `SoftDelete` and
    /// `HardDelete`. For `SoftDelete` (default), feature columns are set
    /// to `null` and the record is no longer retrievable by `GetRecord` or
    /// `BatchGetRecord`. For `HardDelete`, the complete
    /// `Record` is removed from the `OnlineStore`. In both cases, Feature
    /// Store appends the deleted record marker to the `OfflineStore`. The deleted
    /// record marker is a record with the same `RecordIdentifer` as the original,
    /// but
    /// with `is_deleted` value set to `True`, `EventTime` set to
    /// the delete input `EventTime`, and other feature values set to
    /// `null`.
    ///
    /// Note that the `EventTime` specified in `DeleteRecord` should be
    /// set later than the `EventTime` of the existing record in the
    /// `OnlineStore` for that `RecordIdentifer`. If it is not, the
    /// deletion does not occur:
    ///
    /// * For `SoftDelete`, the existing (not deleted) record remains in the
    /// `OnlineStore`, though the delete record marker is still written to the
    /// `OfflineStore`.
    ///
    /// * `HardDelete` returns `EventTime`: `400
    /// ValidationException` to indicate that the delete operation failed. No delete
    /// record marker is written to the `OfflineStore`.
    ///
    /// When a record is deleted from the `OnlineStore`, the deleted record marker
    /// is
    /// appended to the `OfflineStore`. If you have the Iceberg table format enabled
    /// for
    /// your `OfflineStore`, you can remove all history of a record from the
    /// `OfflineStore` using Amazon Athena or Apache Spark. For information on how
    /// to
    /// hard delete a record from the `OfflineStore` with the Iceberg table format
    /// enabled, see [Delete records from the offline
    /// store](https://docs.aws.amazon.com/sagemaker/latest/dg/feature-store-delete-records-offline-store.html#feature-store-delete-records-offline-store).
    pub fn deleteRecord(self: *Self, allocator: std.mem.Allocator, input: delete_record.DeleteRecordInput, options: CallOptions) !delete_record.DeleteRecordOutput {
        return delete_record.execute(self, allocator, input, options);
    }

    /// Use for `OnlineStore` serving from a `FeatureStore`. Only the
    /// latest records stored in the `OnlineStore` can be retrieved. If no Record
    /// with
    /// `RecordIdentifierValue` is found, then an empty result is returned.
    pub fn getRecord(self: *Self, allocator: std.mem.Allocator, input: get_record.GetRecordInput, options: CallOptions) !get_record.GetRecordOutput {
        return get_record.execute(self, allocator, input, options);
    }

    /// The `PutRecord` API is used to ingest a list of `Records` into
    /// your feature group.
    ///
    /// If a new record’s `EventTime` is greater, the new record is written to both
    /// the `OnlineStore` and `OfflineStore`. Otherwise, the record is a
    /// historic record and it is written only to the `OfflineStore`.
    ///
    /// You can specify the ingestion to be applied to the `OnlineStore`,
    /// `OfflineStore`, or both by using the `TargetStores` request
    /// parameter.
    ///
    /// You can set the ingested record to expire at a given time to live (TTL)
    /// duration after
    /// the record’s event time, `ExpiresAt` = `EventTime` +
    /// `TtlDuration`, by specifying the `TtlDuration` parameter. A record
    /// level `TtlDuration` is set when specifying the `TtlDuration`
    /// parameter using the `PutRecord` API call. If the input `TtlDuration`
    /// is `null` or unspecified, `TtlDuration` is set to the default feature
    /// group level `TtlDuration`. A record level `TtlDuration` supersedes
    /// the group level `TtlDuration`.
    pub fn putRecord(self: *Self, allocator: std.mem.Allocator, input: put_record.PutRecordInput, options: CallOptions) !put_record.PutRecordOutput {
        return put_record.execute(self, allocator, input, options);
    }
};
