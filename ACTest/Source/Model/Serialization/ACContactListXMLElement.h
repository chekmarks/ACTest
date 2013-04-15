
// Definition of the XML elements encountered in an XML Contact List representation

typedef enum XMLElement
{
	XMLElementContactList,
	XMLElementContact,
	XMLElementFirstName,
	XMLElementLastName,
	XMLElementAge,
	XMLElementSex,
	XMLElementPicture,
	XMLElementNotes,

	XMLElementUnknown
}
XMLElement;


// Methods to query and manage a string-to-XMLElement lookup table

XMLElement XMLElementFromNSString( NSString* elementName );
void       XMLElementFromNSStringPurgeCache();