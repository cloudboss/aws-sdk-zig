const aws = @import("aws");
const std = @import("std");

const search_ = @import("search.zig");
const suggest_ = @import("suggest.zig");
const upload_documents = @import("upload_documents.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudSearch Domain";

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

    /// Retrieves a list of documents that match the specified search criteria. How
    /// you specify the search criteria depends on which query parser you use.
    /// Amazon CloudSearch supports four query parsers:
    ///
    /// * `simple`: search all `text` and `text-array` fields for the specified
    ///   string. Search for phrases, individual terms, and prefixes.
    ///
    /// * `structured`: search specific fields, construct compound queries using
    ///   Boolean operators, and use advanced features such as term boosting and
    ///   proximity searching.
    ///
    /// * `lucene`: specify search criteria using the Apache Lucene query parser
    ///   syntax.
    ///
    /// * `dismax`: specify search criteria using the simplified subset of the
    ///   Apache Lucene query parser syntax defined by the DisMax query parser.
    ///
    /// For more information, see [Searching Your
    /// Data](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/searching.html) in the *Amazon CloudSearch Developer Guide*.
    ///
    /// The endpoint for submitting `Search` requests is domain-specific. You submit
    /// search requests to a domain's search endpoint. To get the search endpoint
    /// for your domain, use the Amazon CloudSearch configuration service
    /// `DescribeDomains` action. A domain's endpoints are also displayed on the
    /// domain dashboard in the Amazon CloudSearch console.
    pub fn search(self: *Self, allocator: std.mem.Allocator, input: search_.SearchInput, options: search_.Options) !search_.SearchOutput {
        return search_.execute(self, allocator, input, options);
    }

    /// Retrieves autocomplete suggestions for a partial query string. You can use
    /// suggestions enable you to display likely matches before users finish typing.
    /// In Amazon CloudSearch, suggestions are based on the contents of a particular
    /// text field. When you request suggestions, Amazon CloudSearch finds all of
    /// the documents whose values in the suggester field start with the specified
    /// query string. The beginning of the field must match the query string to be
    /// considered a match.
    ///
    /// For more information about configuring suggesters and retrieving
    /// suggestions, see [Getting
    /// Suggestions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html) in the *Amazon CloudSearch Developer Guide*.
    ///
    /// The endpoint for submitting `Suggest` requests is domain-specific. You
    /// submit suggest requests to a domain's search endpoint. To get the search
    /// endpoint for your domain, use the Amazon CloudSearch configuration service
    /// `DescribeDomains` action. A domain's endpoints are also displayed on the
    /// domain dashboard in the Amazon CloudSearch console.
    pub fn suggest(self: *Self, allocator: std.mem.Allocator, input: suggest_.SuggestInput, options: suggest_.Options) !suggest_.SuggestOutput {
        return suggest_.execute(self, allocator, input, options);
    }

    /// Posts a batch of documents to a search domain for indexing. A document batch
    /// is a collection of add and delete operations that represent the documents
    /// you want to add, update, or delete from your domain. Batches can be
    /// described in either JSON or XML. Each item that you want Amazon CloudSearch
    /// to return as a search result (such as a product) is represented as a
    /// document. Every document has a unique ID and one or more fields that contain
    /// the data that you want to search and return in results. Individual documents
    /// cannot contain more than 1 MB of data. The entire batch cannot exceed 5 MB.
    /// To get the best possible upload performance, group add and delete operations
    /// in batches that are close the 5 MB limit. Submitting a large volume of
    /// single-document batches can overload a domain's document service.
    ///
    /// The endpoint for submitting `UploadDocuments` requests is domain-specific.
    /// To get the document endpoint for your domain, use the Amazon CloudSearch
    /// configuration service `DescribeDomains` action. A domain's endpoints are
    /// also displayed on the domain dashboard in the Amazon CloudSearch console.
    ///
    /// For more information about formatting your data for Amazon CloudSearch, see
    /// [Preparing Your
    /// Data](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/preparing-data.html) in the *Amazon CloudSearch Developer Guide*.
    /// For more information about uploading data for indexing, see [Uploading
    /// Data](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/uploading-data.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn uploadDocuments(self: *Self, allocator: std.mem.Allocator, input: upload_documents.UploadDocumentsInput, options: upload_documents.Options) !upload_documents.UploadDocumentsOutput {
        return upload_documents.execute(self, allocator, input, options);
    }
};
