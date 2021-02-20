const title = "I Gotta Feeling";

function pause() {
  //no return
}

function isPlaying() {
  return true;
}

function getTitle() {
  return title;
}

function getDuration() {
  return 289.0;
}

function addAlbums(albums: string[]) {
  postMessage("Albums added!");
  return albums;
}
