# SHFile
Preserve files (datas) in the local temporary or documents directory.

## Usage
If you would like to store files in the temporary directory,
you can invoke the set-up method at first.

    [SHFile setUpTemporaryDirectory];

Create a file by a given name and data,
and save the file in the temporary directory.

    NSData *data = ...;
    SHFile *file = [SHFile fileWithName:@"filename.txt" data:data];
    NSError *error = nil;
    [file saveInTemporaryDirectory:&error];

Delete the data in the temporary directory.

    [file deleteInTemporaryDirectory:&error];

Clean up the temporary directory.

    [SHFile cleanTemporaryDirectory];

It's also possible to store files in the documents directory,
and you should invoke the other set-up method at first.

    [SHFile setUpDocumentsDirectory];

Similarly, you're able to save or to delete the file in the documents directory.

    NSData *data = ...;
    SHFile *file = [SHFile fileWithName:@"filename.txt" data:data];
    NSError *error = nil;
    [file saveInDocumentsDirectory:&error];

    // ...

    [file deleteInDocumentsDirectory:&error];
