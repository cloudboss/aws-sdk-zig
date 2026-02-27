/// The progress report for the import job.
pub const JobProgressReport = struct {
    /// The transaction rate the import job is processed at.
    throughput: ?f64,

    /// The number of files that failed to be read from the S3 input bucket due to
    /// customer
    /// error.
    total_number_of_files_read_with_customer_error: ?i64,

    /// The number of files imported.
    total_number_of_imported_files: ?i64,

    /// The number of resources imported.
    total_number_of_resources_imported: ?i64,

    /// The number of resources scanned from the S3 input bucket.
    total_number_of_resources_scanned: ?i64,

    /// The number of resources that failed due to customer error.
    total_number_of_resources_with_customer_error: ?i64,

    /// The number of files scanned from the S3 input bucket.
    total_number_of_scanned_files: ?i64,

    /// The size (in MB) of files scanned from the S3 input bucket.
    total_size_of_scanned_files_in_mb: ?f64,

    pub const json_field_names = .{
        .throughput = "Throughput",
        .total_number_of_files_read_with_customer_error = "TotalNumberOfFilesReadWithCustomerError",
        .total_number_of_imported_files = "TotalNumberOfImportedFiles",
        .total_number_of_resources_imported = "TotalNumberOfResourcesImported",
        .total_number_of_resources_scanned = "TotalNumberOfResourcesScanned",
        .total_number_of_resources_with_customer_error = "TotalNumberOfResourcesWithCustomerError",
        .total_number_of_scanned_files = "TotalNumberOfScannedFiles",
        .total_size_of_scanned_files_in_mb = "TotalSizeOfScannedFilesInMB",
    };
};
