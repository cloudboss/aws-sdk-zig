const aws = @import("aws");
const std = @import("std");

const analyze_document = @import("analyze_document.zig");
const analyze_expense = @import("analyze_expense.zig");
const analyze_id = @import("analyze_id.zig");
const create_adapter = @import("create_adapter.zig");
const create_adapter_version = @import("create_adapter_version.zig");
const delete_adapter = @import("delete_adapter.zig");
const delete_adapter_version = @import("delete_adapter_version.zig");
const detect_document_text = @import("detect_document_text.zig");
const get_adapter = @import("get_adapter.zig");
const get_adapter_version = @import("get_adapter_version.zig");
const get_document_analysis = @import("get_document_analysis.zig");
const get_document_text_detection = @import("get_document_text_detection.zig");
const get_expense_analysis = @import("get_expense_analysis.zig");
const get_lending_analysis = @import("get_lending_analysis.zig");
const get_lending_analysis_summary = @import("get_lending_analysis_summary.zig");
const list_adapter_versions = @import("list_adapter_versions.zig");
const list_adapters = @import("list_adapters.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_document_analysis = @import("start_document_analysis.zig");
const start_document_text_detection = @import("start_document_text_detection.zig");
const start_expense_analysis = @import("start_expense_analysis.zig");
const start_lending_analysis = @import("start_lending_analysis.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_adapter = @import("update_adapter.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Textract";

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

    /// Analyzes an input document for relationships between detected items.
    ///
    /// The types of information returned are as follows:
    ///
    /// * Form data (key-value pairs). The related information is returned in two
    ///   Block objects, each of type `KEY_VALUE_SET`: a KEY
    /// `Block` object and a VALUE `Block` object. For example,
    /// *Name: Ana Silva Carolina* contains a key and value.
    /// *Name:* is the key. *Ana Silva Carolina* is
    /// the value.
    ///
    /// * Table and table cell data. A TABLE `Block` object contains information
    /// about a detected table. A CELL `Block` object is returned for each cell in
    /// a table.
    ///
    /// * Lines and words of text. A LINE `Block` object contains one or more
    /// WORD `Block` objects. All lines and words that are detected in the
    /// document are returned (including text that doesn't have a relationship with
    /// the value
    /// of `FeatureTypes`).
    ///
    /// * Signatures. A SIGNATURE `Block` object contains the location information
    /// of a signature in a document. If used in conjunction with forms or tables, a
    /// signature
    /// can be given a Key-Value pairing or be detected in the cell of a table.
    ///
    /// * Query. A QUERY Block object contains the query text, alias and link to the
    /// associated Query results block object.
    ///
    /// * Query Result. A QUERY_RESULT Block object contains the answer to the query
    ///   and an
    /// ID that connects it to the query asked. This Block also contains a
    /// confidence
    /// score.
    ///
    /// Selection elements such as check boxes and option buttons (radio buttons)
    /// can be
    /// detected in form data and in tables. A SELECTION_ELEMENT `Block` object
    /// contains
    /// information about a selection element, including the selection status.
    ///
    /// You can choose which type of analysis to perform by specifying the
    /// `FeatureTypes` list.
    ///
    /// The output is returned in a list of `Block` objects.
    ///
    /// `AnalyzeDocument` is a synchronous operation. To analyze documents
    /// asynchronously, use StartDocumentAnalysis.
    ///
    /// For more information, see [Document Text
    /// Analysis](https://docs.aws.amazon.com/textract/latest/dg/how-it-works-analyzing.html).
    pub fn analyzeDocument(self: *Self, allocator: std.mem.Allocator, input: analyze_document.AnalyzeDocumentInput, options: analyze_document.Options) !analyze_document.AnalyzeDocumentOutput {
        return analyze_document.execute(self, allocator, input, options);
    }

    /// `AnalyzeExpense` synchronously analyzes an input document for financially
    /// related relationships between text.
    ///
    /// Information is returned as `ExpenseDocuments` and seperated as
    /// follows:
    ///
    /// * `LineItemGroups`- A data set containing `LineItems` which
    /// store information about the lines of text, such as an item purchased and its
    /// price on
    /// a receipt.
    ///
    /// * `SummaryFields`- Contains all other information a receipt, such as
    /// header information or the vendors name.
    pub fn analyzeExpense(self: *Self, allocator: std.mem.Allocator, input: analyze_expense.AnalyzeExpenseInput, options: analyze_expense.Options) !analyze_expense.AnalyzeExpenseOutput {
        return analyze_expense.execute(self, allocator, input, options);
    }

    /// Analyzes identity documents for relevant information. This information is
    /// extracted and
    /// returned as `IdentityDocumentFields`, which records both the normalized
    /// field
    /// and value of the extracted text. Unlike other Amazon Textract operations,
    /// `AnalyzeID` doesn't return any Geometry data.
    pub fn analyzeId(self: *Self, allocator: std.mem.Allocator, input: analyze_id.AnalyzeIDInput, options: analyze_id.Options) !analyze_id.AnalyzeIDOutput {
        return analyze_id.execute(self, allocator, input, options);
    }

    /// Creates an adapter, which can be fine-tuned for enhanced performance on user
    /// provided
    /// documents. Takes an AdapterName and FeatureType. Currently the only
    /// supported feature type
    /// is `QUERIES`. You can also provide a Description, Tags, and a
    /// ClientRequestToken. You can choose whether or not the adapter should be
    /// AutoUpdated with
    /// the AutoUpdate argument. By default, AutoUpdate is set to DISABLED.
    pub fn createAdapter(self: *Self, allocator: std.mem.Allocator, input: create_adapter.CreateAdapterInput, options: create_adapter.Options) !create_adapter.CreateAdapterOutput {
        return create_adapter.execute(self, allocator, input, options);
    }

    /// Creates a new version of an adapter. Operates on a provided AdapterId and a
    /// specified
    /// dataset provided via the DatasetConfig argument. Requires that you
    /// specify an Amazon S3 bucket with the OutputConfig argument. You can provide
    /// an optional KMSKeyId,
    /// an optional ClientRequestToken, and optional tags.
    pub fn createAdapterVersion(self: *Self, allocator: std.mem.Allocator, input: create_adapter_version.CreateAdapterVersionInput, options: create_adapter_version.Options) !create_adapter_version.CreateAdapterVersionOutput {
        return create_adapter_version.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Textract adapter. Takes an AdapterId and deletes the
    /// adapter specified by the ID.
    pub fn deleteAdapter(self: *Self, allocator: std.mem.Allocator, input: delete_adapter.DeleteAdapterInput, options: delete_adapter.Options) !delete_adapter.DeleteAdapterOutput {
        return delete_adapter.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Textract adapter version. Requires that you specify both
    /// an AdapterId and a
    /// AdapterVersion. Deletes the adapter version specified by the AdapterId and
    /// the AdapterVersion.
    pub fn deleteAdapterVersion(self: *Self, allocator: std.mem.Allocator, input: delete_adapter_version.DeleteAdapterVersionInput, options: delete_adapter_version.Options) !delete_adapter_version.DeleteAdapterVersionOutput {
        return delete_adapter_version.execute(self, allocator, input, options);
    }

    /// Detects text in the input document. Amazon Textract can detect lines of text
    /// and the
    /// words that make up a line of text. The input document must be in one of the
    /// following image
    /// formats: JPEG, PNG, PDF, or TIFF. `DetectDocumentText` returns the detected
    /// text in an array of Block objects.
    ///
    /// Each document page has as an associated `Block` of type PAGE. Each PAGE
    /// `Block` object
    /// is the parent of LINE `Block` objects that represent the lines of detected
    /// text on a page. A LINE `Block` object is
    /// a parent for each word that makes up the line. Words are represented by
    /// `Block` objects of type WORD.
    ///
    /// `DetectDocumentText` is a synchronous operation. To analyze documents
    /// asynchronously, use StartDocumentTextDetection.
    ///
    /// For more information, see [Document Text
    /// Detection](https://docs.aws.amazon.com/textract/latest/dg/how-it-works-detecting.html).
    pub fn detectDocumentText(self: *Self, allocator: std.mem.Allocator, input: detect_document_text.DetectDocumentTextInput, options: detect_document_text.Options) !detect_document_text.DetectDocumentTextOutput {
        return detect_document_text.execute(self, allocator, input, options);
    }

    /// Gets configuration information for an adapter specified by an AdapterId,
    /// returning information on AdapterName, Description,
    /// CreationTime, AutoUpdate status, and FeatureTypes.
    pub fn getAdapter(self: *Self, allocator: std.mem.Allocator, input: get_adapter.GetAdapterInput, options: get_adapter.Options) !get_adapter.GetAdapterOutput {
        return get_adapter.execute(self, allocator, input, options);
    }

    /// Gets configuration information for the specified adapter version, including:
    /// AdapterId, AdapterVersion, FeatureTypes, Status, StatusMessage,
    /// DatasetConfig,
    /// KMSKeyId, OutputConfig, Tags and EvaluationMetrics.
    pub fn getAdapterVersion(self: *Self, allocator: std.mem.Allocator, input: get_adapter_version.GetAdapterVersionInput, options: get_adapter_version.Options) !get_adapter_version.GetAdapterVersionOutput {
        return get_adapter_version.execute(self, allocator, input, options);
    }

    /// Gets the results for an Amazon Textract asynchronous operation that analyzes
    /// text in a
    /// document.
    ///
    /// You start asynchronous text analysis by calling StartDocumentAnalysis,
    /// which returns a job identifier (`JobId`). When the text analysis operation
    /// finishes, Amazon Textract publishes a completion status to the Amazon Simple
    /// Notification Service (Amazon SNS) topic
    /// that's registered in the initial call to `StartDocumentAnalysis`. To get the
    /// results of the text-detection operation, first check that the status value
    /// published to the
    /// Amazon SNS topic is `SUCCEEDED`. If so, call `GetDocumentAnalysis`, and
    /// pass the job identifier (`JobId`) from the initial call to
    /// `StartDocumentAnalysis`.
    ///
    /// `GetDocumentAnalysis` returns an array of Block objects.
    /// The following types of information are returned:
    ///
    /// * Form data (key-value pairs). The related information is returned in two
    ///   Block objects, each of type `KEY_VALUE_SET`: a KEY
    /// `Block` object and a VALUE `Block` object. For example,
    /// *Name: Ana Silva Carolina* contains a key and value.
    /// *Name:* is the key. *Ana Silva Carolina* is
    /// the value.
    ///
    /// * Table and table cell data. A TABLE `Block` object contains information
    /// about a detected table. A CELL `Block` object is returned for each cell in
    /// a table.
    ///
    /// * Lines and words of text. A LINE `Block` object contains one or more
    /// WORD `Block` objects. All lines and words that are detected in the
    /// document are returned (including text that doesn't have a relationship with
    /// the value
    /// of the `StartDocumentAnalysis`
    /// `FeatureTypes` input parameter).
    ///
    /// * Query. A QUERY Block object contains the query text, alias and link to the
    /// associated Query results block object.
    ///
    /// * Query Results. A QUERY_RESULT Block object contains the answer to the
    ///   query and an
    /// ID that connects it to the query asked. This Block also contains a
    /// confidence
    /// score.
    ///
    /// While processing a document with queries, look out for
    /// `INVALID_REQUEST_PARAMETERS` output. This indicates that either the per
    /// page query limit has been exceeded or that the operation is trying to query
    /// a page in
    /// the document which doesn’t exist.
    ///
    /// Selection elements such as check boxes and option buttons (radio buttons)
    /// can be
    /// detected in form data and in tables. A SELECTION_ELEMENT `Block` object
    /// contains
    /// information about a selection element, including the selection status.
    ///
    /// Use the `MaxResults` parameter to limit the number of blocks that are
    /// returned. If there are more results than specified in `MaxResults`, the
    /// value of
    /// `NextToken` in the operation response contains a pagination token for
    /// getting
    /// the next set of results. To get the next page of results, call
    /// `GetDocumentAnalysis`, and populate the `NextToken` request
    /// parameter with the token value that's returned from the previous call to
    /// `GetDocumentAnalysis`.
    ///
    /// For more information, see [Document Text
    /// Analysis](https://docs.aws.amazon.com/textract/latest/dg/how-it-works-analyzing.html).
    pub fn getDocumentAnalysis(self: *Self, allocator: std.mem.Allocator, input: get_document_analysis.GetDocumentAnalysisInput, options: get_document_analysis.Options) !get_document_analysis.GetDocumentAnalysisOutput {
        return get_document_analysis.execute(self, allocator, input, options);
    }

    /// Gets the results for an Amazon Textract asynchronous operation that detects
    /// text in a document.
    /// Amazon Textract can detect lines of text and the words that make up a line
    /// of text.
    ///
    /// You start asynchronous text detection by calling StartDocumentTextDetection,
    /// which returns a job identifier
    /// (`JobId`). When the text detection operation finishes, Amazon Textract
    /// publishes a
    /// completion status to the Amazon Simple Notification Service (Amazon SNS)
    /// topic that's registered in the initial call to
    /// `StartDocumentTextDetection`. To get the results of the text-detection
    /// operation, first check that the status value published to the Amazon SNS
    /// topic is
    /// `SUCCEEDED`. If so, call `GetDocumentTextDetection`, and pass the
    /// job identifier (`JobId`) from the initial call to
    /// `StartDocumentTextDetection`.
    ///
    /// `GetDocumentTextDetection` returns an array of Block
    /// objects.
    ///
    /// Each document page has as an associated `Block` of type PAGE. Each PAGE
    /// `Block` object
    /// is the parent of LINE `Block` objects that represent the lines of detected
    /// text on a page. A LINE `Block` object is
    /// a parent for each word that makes up the line. Words are represented by
    /// `Block` objects of type WORD.
    ///
    /// Use the MaxResults parameter to limit the number of blocks that are
    /// returned. If there
    /// are more results than specified in `MaxResults`, the value of
    /// `NextToken` in the operation response contains a pagination token for
    /// getting
    /// the next set of results. To get the next page of results, call
    /// `GetDocumentTextDetection`, and populate the `NextToken` request
    /// parameter with the token value that's returned from the previous call to
    /// `GetDocumentTextDetection`.
    ///
    /// For more information, see [Document Text
    /// Detection](https://docs.aws.amazon.com/textract/latest/dg/how-it-works-detecting.html).
    pub fn getDocumentTextDetection(self: *Self, allocator: std.mem.Allocator, input: get_document_text_detection.GetDocumentTextDetectionInput, options: get_document_text_detection.Options) !get_document_text_detection.GetDocumentTextDetectionOutput {
        return get_document_text_detection.execute(self, allocator, input, options);
    }

    /// Gets the results for an Amazon Textract asynchronous operation that analyzes
    /// invoices and
    /// receipts. Amazon Textract finds contact information, items purchased, and
    /// vendor name, from input
    /// invoices and receipts.
    ///
    /// You start asynchronous invoice/receipt analysis by calling
    /// StartExpenseAnalysis, which returns a job identifier (`JobId`). Upon
    /// completion of the invoice/receipt analysis, Amazon Textract publishes the
    /// completion status to the
    /// Amazon Simple Notification Service (Amazon SNS) topic. This topic must be
    /// registered in the initial call to
    /// `StartExpenseAnalysis`. To get the results of the invoice/receipt analysis
    /// operation,
    /// first ensure that the status value published to the Amazon SNS topic is
    /// `SUCCEEDED`. If so,
    /// call `GetExpenseAnalysis`, and pass the job identifier (`JobId`) from the
    /// initial call to `StartExpenseAnalysis`.
    ///
    /// Use the MaxResults parameter to limit the number of blocks that are
    /// returned. If there are
    /// more results than specified in `MaxResults`, the value of `NextToken` in
    /// the operation response contains a pagination token for getting the next set
    /// of results. To get
    /// the next page of results, call `GetExpenseAnalysis`, and populate the
    /// `NextToken` request parameter with the token value that's returned from the
    /// previous
    /// call to `GetExpenseAnalysis`.
    ///
    /// For more information, see [Analyzing Invoices and
    /// Receipts](https://docs.aws.amazon.com/textract/latest/dg/invoices-receipts.html).
    pub fn getExpenseAnalysis(self: *Self, allocator: std.mem.Allocator, input: get_expense_analysis.GetExpenseAnalysisInput, options: get_expense_analysis.Options) !get_expense_analysis.GetExpenseAnalysisOutput {
        return get_expense_analysis.execute(self, allocator, input, options);
    }

    /// Gets the results for an Amazon Textract asynchronous operation that analyzes
    /// text in a
    /// lending document.
    ///
    /// You start asynchronous text analysis by calling `StartLendingAnalysis`,
    /// which returns a job identifier (`JobId`). When the text analysis operation
    /// finishes, Amazon Textract publishes a completion status to the Amazon Simple
    /// Notification Service (Amazon SNS) topic that's registered in the initial
    /// call to
    /// `StartLendingAnalysis`.
    ///
    /// To get the results of the text analysis operation, first check that the
    /// status value
    /// published to the Amazon SNS topic is SUCCEEDED. If so, call
    /// GetLendingAnalysis, and pass
    /// the job identifier (`JobId`) from the initial call to
    /// `StartLendingAnalysis`.
    pub fn getLendingAnalysis(self: *Self, allocator: std.mem.Allocator, input: get_lending_analysis.GetLendingAnalysisInput, options: get_lending_analysis.Options) !get_lending_analysis.GetLendingAnalysisOutput {
        return get_lending_analysis.execute(self, allocator, input, options);
    }

    /// Gets summarized results for the `StartLendingAnalysis` operation, which
    /// analyzes
    /// text in a lending document. The returned summary consists of information
    /// about documents grouped
    /// together by a common document type. Information like detected signatures,
    /// page numbers, and split
    /// documents is returned with respect to the type of grouped document.
    ///
    /// You start asynchronous text analysis by calling `StartLendingAnalysis`,
    /// which
    /// returns a job identifier (`JobId`). When the text analysis operation
    /// finishes, Amazon
    /// Textract publishes a completion status to the Amazon Simple Notification
    /// Service (Amazon SNS)
    /// topic that's registered in the initial call to `StartLendingAnalysis`.
    ///
    /// To get the results of the text analysis operation, first check that the
    /// status value
    /// published to the Amazon SNS topic is SUCCEEDED. If so, call
    /// `GetLendingAnalysisSummary`, and pass the job identifier (`JobId`) from
    /// the initial call to `StartLendingAnalysis`.
    pub fn getLendingAnalysisSummary(self: *Self, allocator: std.mem.Allocator, input: get_lending_analysis_summary.GetLendingAnalysisSummaryInput, options: get_lending_analysis_summary.Options) !get_lending_analysis_summary.GetLendingAnalysisSummaryOutput {
        return get_lending_analysis_summary.execute(self, allocator, input, options);
    }

    /// List all version of an adapter that meet the specified filtration criteria.
    pub fn listAdapterVersions(self: *Self, allocator: std.mem.Allocator, input: list_adapter_versions.ListAdapterVersionsInput, options: list_adapter_versions.Options) !list_adapter_versions.ListAdapterVersionsOutput {
        return list_adapter_versions.execute(self, allocator, input, options);
    }

    /// Lists all adapters that match the specified filtration criteria.
    pub fn listAdapters(self: *Self, allocator: std.mem.Allocator, input: list_adapters.ListAdaptersInput, options: list_adapters.Options) !list_adapters.ListAdaptersOutput {
        return list_adapters.execute(self, allocator, input, options);
    }

    /// Lists all tags for an Amazon Textract resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts the asynchronous analysis of an input document for relationships
    /// between detected
    /// items such as key-value pairs, tables, and selection elements.
    ///
    /// `StartDocumentAnalysis` can analyze text in documents that are in JPEG, PNG,
    /// TIFF, and PDF format. The
    /// documents are stored in an Amazon S3 bucket. Use DocumentLocation to specify
    /// the bucket name and file name
    /// of the document.
    ///
    /// `StartDocumentAnalysis` returns a job identifier
    /// (`JobId`) that you use to get the results of the operation. When text
    /// analysis is finished, Amazon Textract publishes a completion status to the
    /// Amazon Simple Notification Service (Amazon SNS)
    /// topic that you specify in `NotificationChannel`. To get the results of the
    /// text
    /// analysis operation, first check that the status value published to the
    /// Amazon SNS topic is
    /// `SUCCEEDED`. If so, call GetDocumentAnalysis, and pass
    /// the job identifier (`JobId`) from the initial call to
    /// `StartDocumentAnalysis`.
    ///
    /// For more information, see [Document Text
    /// Analysis](https://docs.aws.amazon.com/textract/latest/dg/how-it-works-analyzing.html).
    pub fn startDocumentAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_document_analysis.StartDocumentAnalysisInput, options: start_document_analysis.Options) !start_document_analysis.StartDocumentAnalysisOutput {
        return start_document_analysis.execute(self, allocator, input, options);
    }

    /// Starts the asynchronous detection of text in a document. Amazon Textract can
    /// detect lines of
    /// text and the words that make up a line of text.
    ///
    /// `StartDocumentTextDetection` can analyze text in documents that are in JPEG,
    /// PNG, TIFF, and PDF format. The
    /// documents are stored in an Amazon S3 bucket. Use DocumentLocation to specify
    /// the bucket name and file name
    /// of the document.
    ///
    /// `StartDocumentTextDetection` returns a job identifier
    /// (`JobId`) that you use to get the results of the operation. When text
    /// detection is finished, Amazon Textract publishes a completion status to the
    /// Amazon Simple Notification Service (Amazon SNS)
    /// topic that you specify in `NotificationChannel`. To get the results of the
    /// text
    /// detection operation, first check that the status value published to the
    /// Amazon SNS topic is
    /// `SUCCEEDED`. If so, call GetDocumentTextDetection, and
    /// pass the job identifier (`JobId`) from the initial call to
    /// `StartDocumentTextDetection`.
    ///
    /// For more information, see [Document Text
    /// Detection](https://docs.aws.amazon.com/textract/latest/dg/how-it-works-detecting.html).
    pub fn startDocumentTextDetection(self: *Self, allocator: std.mem.Allocator, input: start_document_text_detection.StartDocumentTextDetectionInput, options: start_document_text_detection.Options) !start_document_text_detection.StartDocumentTextDetectionOutput {
        return start_document_text_detection.execute(self, allocator, input, options);
    }

    /// Starts the asynchronous analysis of invoices or receipts for data like
    /// contact information,
    /// items purchased, and vendor names.
    ///
    /// `StartExpenseAnalysis` can analyze text in documents that are in JPEG, PNG,
    /// and
    /// PDF format. The documents must be stored in an Amazon S3 bucket. Use the
    /// DocumentLocation parameter to specify the name of your S3 bucket and the
    /// name of the
    /// document in that bucket.
    ///
    /// `StartExpenseAnalysis` returns a job identifier (`JobId`) that you
    /// will provide to `GetExpenseAnalysis` to retrieve the results of the
    /// operation. When
    /// the analysis of the input invoices/receipts is finished, Amazon Textract
    /// publishes a completion
    /// status to the Amazon Simple Notification Service (Amazon SNS) topic that you
    /// provide to the `NotificationChannel`.
    /// To obtain the results of the invoice and receipt analysis operation, ensure
    /// that the status value
    /// published to the Amazon SNS topic is `SUCCEEDED`. If so, call
    /// GetExpenseAnalysis, and pass the job identifier (`JobId`) that was
    /// returned by your call to `StartExpenseAnalysis`.
    ///
    /// For more information, see [Analyzing Invoices and
    /// Receipts](https://docs.aws.amazon.com/textract/latest/dg/invoice-receipts.html).
    pub fn startExpenseAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_expense_analysis.StartExpenseAnalysisInput, options: start_expense_analysis.Options) !start_expense_analysis.StartExpenseAnalysisOutput {
        return start_expense_analysis.execute(self, allocator, input, options);
    }

    /// Starts the classification and analysis of an input document.
    /// `StartLendingAnalysis` initiates the classification and analysis of a packet
    /// of
    /// lending documents. `StartLendingAnalysis` operates on a document file
    /// located in an
    /// Amazon S3 bucket.
    ///
    /// `StartLendingAnalysis` can analyze text in documents that are in one of the
    /// following formats: JPEG, PNG, TIFF, PDF. Use `DocumentLocation` to specify
    /// the bucket
    /// name and the file name of the document.
    ///
    /// `StartLendingAnalysis` returns a job identifier (`JobId`) that you use
    /// to get the results of the operation. When the text analysis is finished,
    /// Amazon Textract
    /// publishes a completion status to the Amazon Simple Notification Service
    /// (Amazon SNS) topic that
    /// you specify in `NotificationChannel`. To get the results of the text
    /// analysis
    /// operation, first check that the status value published to the Amazon SNS
    /// topic is SUCCEEDED. If
    /// the status is SUCCEEDED you can call either `GetLendingAnalysis` or
    /// `GetLendingAnalysisSummary` and provide the `JobId` to obtain the results
    /// of the analysis.
    ///
    /// If using `OutputConfig` to specify an Amazon S3 bucket, the output will be
    /// contained
    /// within the specified prefix in a directory labeled with the job-id. In the
    /// directory there are 3
    /// sub-directories:
    ///
    /// * detailedResponse (contains the GetLendingAnalysis response)
    ///
    /// * summaryResponse (for the GetLendingAnalysisSummary response)
    ///
    /// * splitDocuments (documents split across logical boundaries)
    pub fn startLendingAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_lending_analysis.StartLendingAnalysisInput, options: start_lending_analysis.Options) !start_lending_analysis.StartLendingAnalysisOutput {
        return start_lending_analysis.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes any tags with the specified keys from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update the configuration for an adapter. FeatureTypes configurations cannot
    /// be updated.
    /// At least one new parameter must be specified as an argument.
    pub fn updateAdapter(self: *Self, allocator: std.mem.Allocator, input: update_adapter.UpdateAdapterInput, options: update_adapter.Options) !update_adapter.UpdateAdapterOutput {
        return update_adapter.execute(self, allocator, input, options);
    }

    pub fn listAdapterVersionsPaginator(self: *Self, params: list_adapter_versions.ListAdapterVersionsInput) paginator.ListAdapterVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAdaptersPaginator(self: *Self, params: list_adapters.ListAdaptersInput) paginator.ListAdaptersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
