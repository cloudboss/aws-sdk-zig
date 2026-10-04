const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

pub const PutRecordInput = struct {
    /// The data blob to put into the record, which is base64-encoded when the blob
    /// is
    /// serialized. When the data blob (the payload before base64-encoding) is added
    /// to the
    /// partition key size, the total size must not exceed the maximum record size
    /// (10
    /// MiB).
    data: []const u8,

    /// Checks if your request will succeed. `DryRun` is an optional
    /// parameter.
    dry_run: ?bool = null,

    /// The hash value used to explicitly determine the shard the data record is
    /// assigned to
    /// by overriding the partition key hash.
    explicit_hash_key: ?[]const u8 = null,

    /// Determines which shard in the stream the data record is assigned to.
    /// Partition keys
    /// are Unicode strings with a maximum length limit of 256 characters for each
    /// key. Amazon
    /// Kinesis Data Streams uses the partition key as input to a hash function that
    /// maps the
    /// partition key and associated data to a specific shard. Specifically, an MD5
    /// hash
    /// function is used to map partition keys to 128-bit integer values and to map
    /// associated
    /// data records to shards. As a result of this hashing mechanism, all data
    /// records with the
    /// same partition key map to the same shard within the stream.
    ///
    /// If the stream uses the `USER_PARTITION_KEY` record distribution strategy
    /// (the default), a partition key is required. If the stream uses the `AUTO`
    /// record distribution strategy, the partition key is optional and any value
    /// you provide is
    /// ignored, along with any `ExplicitHashKey` you provide. In that case, Amazon
    /// Kinesis Data Streams distributes the record across shards using
    /// service-managed
    /// algorithms. For more information, see
    /// `UpdateStreamRecordDistributionStrategy`.
    partition_key: ?[]const u8 = null,

    /// Guarantees strictly increasing sequence numbers, for puts from the same
    /// client and to
    /// the same partition key. Usage: set the `SequenceNumberForOrdering` of record
    /// *n* to the sequence number of record *n-1* (as
    /// returned in the result when putting record *n-1*). If this parameter
    /// is not set, records are coarsely ordered based on arrival time.
    sequence_number_for_ordering: ?[]const u8 = null,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the stream to put the data record into.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "Data",
        .dry_run = "DryRun",
        .explicit_hash_key = "ExplicitHashKey",
        .partition_key = "PartitionKey",
        .sequence_number_for_ordering = "SequenceNumberForOrdering",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
    };
};

pub const PutRecordOutput = struct {
    /// The encryption type to use on the record. This parameter can be one of the
    /// following
    /// values:
    ///
    /// * `NONE`: Do not encrypt the records in the stream.
    ///
    /// * `KMS`: Use server-side encryption on the records in the stream
    /// using a customer-managed Amazon Web Services KMS key.
    encryption_type: ?EncryptionType = null,

    /// The sequence number identifier that was assigned to the put data record. The
    /// sequence
    /// number for the record is unique across all records in the stream. A sequence
    /// number is
    /// the identifier associated with every record put into the stream.
    sequence_number: []const u8,

    /// The shard ID of the shard where the data record was placed.
    shard_id: []const u8,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .sequence_number = "SequenceNumber",
        .shard_id = "ShardId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRecordInput, options: CallOptions) !PutRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.PutRecord");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRecordOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutRecordOutput, body, allocator);
}
