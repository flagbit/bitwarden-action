function getSecretsInputAsArray(secrets) {
  let result = [];
  let secretsArray = secrets.split("\n");

  for (var i = 0; i < secretsArray.length; i++) {
    let secretsLine = secretsArray[i].replace(/\s/g, "");
    if (!secretsLine) {
      continue;
    }

    let secretParts = secretsLine.split("|");
    result.push({
      collectionName: secretParts[0].replace(/\s/g, ""),
      itemName: secretParts[1].replace(/\s/g, ""),
      itemType: secretParts[2].replace(/\s/g, ""),
      envVarName: secretParts[3].replace(/\s/g, ""),
    });
  }

  return result;
}

const bla = getSecretsInputAsArray(process.env.INPUT_SECRETS);
console.log(bla);
