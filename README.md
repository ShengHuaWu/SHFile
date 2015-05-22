# SHFile
Save files (datas) in local temporary directory.

## Usage
Invoke the set up method at first.

    [SHFile setUpTemporaryDirectory];

Create a file by a given name and data, and save the data in the temporary directory.

    NSData *data = ...;
    SHFile *file = [SHFile fileWithName:@"filename.txt" data:data];
    NSError *error = nil;
    [file save:&error];

Remove the data in the temporary directory.

    [file remove:&error];

Clean up the temporary directory.

    [SHFile cleanTemporaryDirectory];
